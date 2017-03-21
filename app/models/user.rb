class User < ApplicationRecord

  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one  :image, as: :imageable, dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy

  validates_uniqueness_of :email, unless: :is_guest?

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable,
         :omniauthable, :omniauth_providers => [:facebook]

  scope  :without_provider, -> { where(provider: nil, uid: nil) }

  def set_fake_password
    generated_password = Devise.friendly_token[0, 20]
    self.password = generated_password
    skip_confirmation!
  end

  def billing_address
    addresses.find_by(kind: :billing)
  end

  def shipping_address
    addresses.find_by(kind: :shipping)
  end

  def self.create_by_token
    token = Devise.friendly_token[0, 20]
    create(guest_token: token)
    token
  end

  def self.from_omniauth(auth)
    @auth = auth
    case
      when where(email: @auth.info.email).without_provider.present?
        @user = where(email: @auth.info.email).without_provider.first
        @user.update_attributes(provider: @auth.provider, uid: @auth.uid)
        save_avatar
      when where(provider: @auth.provider, uid: @auth.uid).empty?
        generated_password = Devise.friendly_token[0, 20]
        @user = create!(
            provider: @auth.provider, uid: @auth.uid,
            email: @auth.info.email, password: generated_password
        )
        save_avatar
        UserMailer.facebook_reg(@user, generated_password).deliver_later if @user.email
    end
    @user || find_by_uid(@auth.uid)
  end

  def self.save_avatar
    if @auth.info.image
      @user.build_image
      @user.image.remote_attachment_url = @auth.info.image.gsub('http://','https://')
    end
  end

  def email_required?
    super && provider.blank? && guest_token.blank?
  end

  def password_required?
    super && provider.blank? && guest_token.blank?
  end

  def confirmation_required?
    super && provider.blank? && guest_token.blank?
  end

  def is_admin?
    role_name.eql? 'admin'
  end

  def is_guest?
    !guest_token.nil?
  end

  def verified?
    orders.after_confirmation.present?
  end
end
