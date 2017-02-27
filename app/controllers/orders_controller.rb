class OrdersController < ApplicationController
  load_and_authorize_resource :order
  def show
    if @order.confirmation_token == confirmation_params[:token]
      @order.confirmed!
      redirect_to order_step_path(id: :complete)
    else
      redirect_to :root
    end
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
