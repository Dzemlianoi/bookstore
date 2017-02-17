class OrderController < ApplicationController
  def index
    byebug
    @books = current_order.order_items.map(&:books)
  end
end
