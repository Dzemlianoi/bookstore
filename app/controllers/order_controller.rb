class OrderController < ApplicationController
  def index
    @purchases = current_order.order_items
    if @purchases.empty?
      flash.keep[:warning] = t('cart.empty_cart')
      redirect_to root_path
    end
  end
end
