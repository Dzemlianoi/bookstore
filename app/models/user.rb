class User < ApplicationRecord

  has_many :reviews, dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :orders, dependent: :destroy

  scope :verified ,-> {}

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

  def verified
    self.orders.find_by(aasm_state: :complited)
  end
end
