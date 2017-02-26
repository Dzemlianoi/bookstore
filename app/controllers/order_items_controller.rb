class OrderItemsController < ApplicationController
  def index
    return redirect_to :root, alert: t('flashes.error.no_order') unless last_is_active?
    @purchases = last_order.order_items
  end

  def create
    @order = current_order || current_user.orders.create
    if book_already_in_order?
      flash.keep[:danger] = t('flashes.error.already_persist')
    else
      @order.order_items.create(create_params)
      flash.keep[:success] = t('flashes.success.book_added')
    end
    redirect_to :books
  end

  def update
    @order_item = current_order.order_items.find(update_params[:id])
    respond_to do |format|
      format.html { redirect_to current_order }
      if @order_item.update(update_params)
        format.json { render json: update_data }
      else
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    current_order.order_items.destroy(destroy_params[:order_item])
    go_back
  end

  private

  def create_params
    params.require(:order_items).permit(:quantity, :book_id)
  end

  def update_params
    params.permit(:id, :quantity)
  end

  def destroy_params
    params.permit(:order_item)
  end

  def book_already_in_order?
    !current_order.order_items.find_by(book: create_params[:book_id]).nil?
  end

  def update_data
    {
      status: :updated,
      coupon: current_order.discount,
      position_price: @order_item.price_with_quantity,
      subtotal_price: current_order.subtotal_price,
      total_price: current_order.total_price
    }
  end
end
