# frozen_string_literal: true

class PricableService
  class << self
    def subtotal_price(order_items)
      order_items.map { |item| item.book[:price] * item.quantity }.inject(&:+)
    end

    def discount(coupon)
      coupon.nil? ? 0 : coupon.discount
    end

    def delivery_price(delivery)
      delivery.nil? ? 0 : delivery.price
    end

    def total_price(order_items, coupon, delivery)
      return 0.00 if order_items.empty?
      price = subtotal_price(order_items) + delivery_price(delivery) - discount(coupon)
      price.positive? ? price : 0.00
    end
  end
end
