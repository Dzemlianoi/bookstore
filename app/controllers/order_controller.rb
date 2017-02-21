class OrderController < ApplicationController
  def index
    @purchases = current_order.order_items
    redirect_to root_path if @purchases.empty?
  end

  def update
    byebug
    user.order.in_confirmation.deliver
  end

  private

  def order_params
    params.require(:order)
  end
end
