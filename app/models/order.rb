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

  def recalculate_total(*record)
    self.update(total_price: total_price)
  end

  def subtotal_price
    self.order_items
        .map { |item| item.book[:price] * item.quantity }
        .reduce(0, :+)
  end

  def total_price
    subtotal_price - discount
  end

  def discount
    self.coupon.nil? ? 0 : self.coupon.discount
  end
end
