class OrdersController < ApplicationController
  def update
    user.order.in_confirmation.deliver
  end

  private

  def active?(order)
    return unless order
    order.checkout_state? && !order(&:order_items).nil?
  end
end
