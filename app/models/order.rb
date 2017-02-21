class Order < ApplicationRecord
  # include AASM
  #
  # aasm do
  #   state :cart, initial: true
  # end
  has_many   :addresses, as: :addressable, dependent: :destroy
  has_many   :order_items, dependent: :destroy,
               after_add: :recalculate_total,
               after_remove: :recalculate_total
  has_many   :books, through: :order_items
  has_one    :coupon
  belongs_to :user
  belongs_to :card
  belongs_to :delivery

  def recalculate_total(*record)
    self.update_attributes(total_price: total_price)
  end

  def subtotal_price
    self.order_items
        .map { |item| item.book[:price] * item.quantity }
        .inject(&:+)
  end

  def total_price
    price = subtotal_price + delivery_price - discount
    price >= 0 ? price : 0.00
  end

  def discount
    self.coupon.nil? ? 0 : self.coupon.discount
  end

  def delivery_price
    self.delivery.nil? ? 0 : self.delivery.price
  end

  def proved?
    self.verified && self.card && self.delivery && self.addresses.count == 2
  end
end
