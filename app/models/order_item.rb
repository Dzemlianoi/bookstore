class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book
  delegate :recalculate_total, to: :order

  after_update :recalculate_total

  def price_with_quantity
    self.book.price * self.quantity.to_f
  end
end
