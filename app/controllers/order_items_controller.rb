class OrderItemsController < ApplicationController
  def create
    @order = current_user.orders.where(aasm_state: 'cart').first_or_create
    if @order.order_items.find_by(book: order_params[:book]).nil?
      @order.order_items.create(order_params)
      success_flash
    else
      error_flash
    end
    redirect_to :books
  end

  def destroy
    current_order.order_items.destroy(destroy_params[:order_item])
    redirect_to :back
  end

  private

  def order_params
    params.require(:order_item).permit(:quantity, :book_id)
  end

  def destroy_params
    params.permit(:order_item)
  end

  def update_params
    params.permit(:order_item, :quantity)
  end

  def success_flash
    flash.keep[:success] = t('flashes.success.book_added')
  end

  def error_flash
    flash.keep[:danger] = t('flashes.error.already_persist')
  end
end
