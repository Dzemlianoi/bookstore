class OrderItemsController < ApplicationController
  def create
    @order = current_user.orders.where(aasm_state: 'cart').first_or_create
    @order.order_items.create(order_params) ? success_flash : error_flash
    redirect_back(fallback_location: root_path)
  end

  private

  def order_params
    params.require(:order_item).permit(:quantity, :book_id)
  end

  def success_flash
    flash.keep[:success] = t('flashes.success.book_added')
  end

  def error_flash
    flash.keep[:danger] = t('flashes.error.already_persist')
  end
end
