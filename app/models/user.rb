# frozen_string_literal: true

class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one  :image, as: :imageable, dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy

  validates_uniqueness_of :email, unless: :guest?

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:facebook]

  scope  :without_provider, -> { where(provider: nil, uid: nil) }
  scope  :user_without_facebook, ->(email) { where(email: email).without_provider }

  def billing_address
    addresses.find_by(kind: :billing)
  end

  def shipping_address
    addresses.find_by(kind: :shipping)
  end

  def self.from_omniauth(auth)
    @auth = auth
    if user_without_facebook(@auth.info.email).present?
      @user = user_without_facebook(@auth.info.email).first.update_attributes(
        uid: @auth.uid, first_name: full_user_name[:first_name],
        last_name: full_user_name[:last_name], provider: @auth.provider
      )
      save_avatar
    elsif where(provider: @auth.provider, uid: @auth.uid).empty?
      generated_password = Devise.friendly_token[0, 20]
      @user = create(
        provider: @auth.provider, uid: @auth.uid, email: @auth.info.email,
        password: generated_password, first_name: full_user_name[:first_name], last_name: full_user_name[:last_name]
      )
      save_avatar
      UserMailer.facebook_reg(@user, generated_password).deliver_later if @user.email
    else
      @user = find_by(uid: @auth.uid)
    end
    @user
  end

  def self.create_by_token
    token = Devise.friendly_token[0, 20]
    create(guest_token: token)
    token
  end

  def self.save_avatar
    return unless @auth.info.image
    @user.build_image
    @user.image.remote_attachment_url = @auth.info.image.gsub('http://', 'https://')
  end

  def self.full_user_name
    names = @auth.info.name.split(' ')
    { first_name: names[0], last_name: names[1] }
  end

  def set_fake_password
    generated_password = Devise.friendly_token[0, 20]
    self.password = generated_password
    skip_confirmation!
  end

  def admin?
    role_name.eql? 'admin'
  end

  def guest?
    !guest_token.nil?
  end

  def verified?
    orders.after_confirmation.present?
  end

  %w(email password confirmation).each do |method_part|
    define_method "#{method_part}_required?" do
      provider.blank? && guest_token.blank?
    end
  end
end
