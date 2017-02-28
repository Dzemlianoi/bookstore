class OrdersController < ApplicationController
  load_and_authorize_resource :order, only: [:show, :confirm]
  load_and_authorize_resource only: :index

  def index
    redirect_to :root, alert: 'No active orders' if @orders.after_cart.empty?
    @orders = @orders.after_cart.order(ordering)
  end

  def show
  end

  def confirm
    if @order.confirmation_token == confirmation_params[:token]
      @order.update_attributes(confirmation_token: nil)
      @order.treat!
      flash.keep[:success] = 'Your order is successfull! One more usefull letter was sent to your email'
    end
    redirect_to :root
  end

  private

  def confirmation_params
    params.permit(:token)
  end

  def active?(order)
    return unless order
    order.checkout_state? && !order(&:order_items).nil?
  end

  def ordering

  end
end
