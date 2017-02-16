class Order < ApplicationRecord
  # include AASM
  #
  # aasm do
  #   state :cart, initial: true
  # end
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :order_items, dependent: :destroy
  belongs_to :user
end
