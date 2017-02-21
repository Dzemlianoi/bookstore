class OrderController < ApplicationController
  def index
    @purchases = current_order.order_items
    redirect_to root_path if @purchases.empty?
  end
end
