class User < ApplicationRecord

  has_many   :reviews

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable,
         :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      generated_password = Devise.friendly_token[0, 20]
      user.password = generated_password
      user.skip_confirmation!
      UserMailer.facebook_reg(user, generated_password).deliver
    end
  end
end
