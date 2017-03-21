class OrdersController < ApplicationController
  load_and_authorize_resource :order, only: [:show, :confirm]
  load_and_authorize_resource only: :index

  helper_method :order_params

  def index
    @orders = @orders.after_cart
    @orders = @orders.send(order_params[:order].to_sym) if status_present?
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

  def status_present?
    return unless order_params[:order]
    Order::MY_ORDERS_STATES.include? order_params[:order].to_sym
  end
end
