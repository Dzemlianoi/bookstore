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
    case
      when where(email: @auth.info.email).without_provider.present?
        @user = where(email: @auth.info.email).without_provider.first
        @user.update_attributes(provider: @auth.provider, uid: @auth.uid)
        save_avatar
      when where(provider: @auth.provider, uid: @auth.uid).empty?
        @user = self.new(provider: @auth.provider, uid: @auth.uid, email: @auth.info.email)
        generated_password = Devise.friendly_token[0, 20]
        @user.password = generated_password
        @user.save
        save_avatar
        @user.skip_confirmation!
        UserMailer.facebook_reg(@user, generated_password).deliver_later if @user.email
    end
    @user || self.find_by_uid(@auth.uid)

  end

  def self.save_avatar
    @user.build_image
    @user.image.remote_attachment_url = @auth.info.image.gsub('http://','https://')
  end

  def email_required?
    super && provider.blank?
  end

  def password_required?
    super && provider.blank?
  end
end
