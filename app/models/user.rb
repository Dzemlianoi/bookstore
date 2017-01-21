class User < ApplicationRecord
  validates :email, :password, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/, message: 'Only emails allowed' }
  validates :password, length: { in: 6..20 }
  validates :password, confirmation: true
end
