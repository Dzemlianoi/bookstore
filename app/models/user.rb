class User < ApplicationRecord

  has_many :reviews, dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one  :image, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :image

  scope  :without_provider,      -> { where(provider: nil, uid: nil) }
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable,
         :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    @auth = auth
    # byebug
    if !where(email: @auth.info.email).without_provider.first.nil?
      user = where(email: @auth.info.email).without_provider.first
      user.update_attributes(provider: @auth.provider, uid: @auth.uid)
      save_avatar(user)
      user
    else
      where(provider: @auth.provider, uid: @auth.uid).first_or_create do |user|
        user.email = auth.info.email
        generated_password = Devise.friendly_token[0, 20]
        user.password = generated_password
        save_avatar(user)
        user.skip_confirmation!
        UserMailer.facebook_reg(user, generated_password).deliver_later if user.email
      end
    end
  end

  def self.save_avatar(user)
    user.build_image
    user.image.remote_attachment_url = @auth.info.image.gsub('http://','https://')
  end

  def already_signuped_with_email
    where(email: @auth.info.email).without_provider.first
  end

  def email_required?
    super && provider.blank?
  end

  def password_required?
    super && provider.blank?
  end
end
