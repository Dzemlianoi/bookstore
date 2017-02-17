class OrderController < ApplicationController
  def index
    @purchases = current_order.order_items
  end
end
