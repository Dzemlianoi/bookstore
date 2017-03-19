class OrdersController < ApplicationController
  load_and_authorize_resource :order, only: [:show, :confirm]
  load_and_authorize_resource only: :index

  helper_method :order_params

  def index
    redirect_to :root, alert: 'No active orders' if @orders.after_cart.empty?
    @orders = @orders.after_cart.order(ordering)
  end

  def show
    @order = @order.decorate
  end

  def confirm
    if @order.confirmation_token == order_params[:token]
      @order.update_attributes(confirmation_token: nil)
      @order.treat!
      flash.keep[:success] = I18n.t('orders.successfull')
    end
    redirect_to :root
  end

  private

  def order_params
    params.permit(:token, :order)
  end

  def ordering
    order = (order_params.key? :order) ? order_params[:order].to_sym : nil
    Order::ORDERING.key?(order) ? Order::ORDERING[order] : Order.default_sort
  end
end
