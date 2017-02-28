class OrdersController < ApplicationController
  load_and_authorize_resource :order

  def show
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
end
