class OrdersController < ApplicationController
  def update
    user.order.in_confirmation.deliver
  end

  private

  def last_is_active?
    return unless last_order
    last_order.checkout_state? && !last_order(&:order_items).nil?
  end
end
