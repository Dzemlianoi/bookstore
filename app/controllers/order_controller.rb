class OrderController < ApplicationController
  def index
    return redirect_to :root, alert: t('flashes.error.no_order') unless last_is_active?
    @purchases = last_order.order_items
  end

  def update
    user.order.in_confirmation.deliver
  end

  private

  def last_is_active?
    return unless last_order
    last_order.checkout_state? && !last_order(&:order_items).nil?
  end
end
