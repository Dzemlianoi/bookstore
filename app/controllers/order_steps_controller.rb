class OrderStepsController < ApplicationController

  before_action :initialize_form

  include Wicked::Wizard
  steps :address, :delivery, :payment, :confirm, :complete

  def show
    check_order_steps if step.eql? :confirm
  end

  def update
    @form.update(step, order_params)
    render_wizard @form
  end

  private

  def order_params
    params.permit(
      :shipping_check,
      :delivery,
      shipping_address: [:first_name, :last_name, :address, :city, :zip, :country, :phone, :kind],
      billing_address:  [:first_name, :last_name, :address, :city, :zip, :country, :phone, :kind],
      credit_card:      [:card_number, :CVV, :expire_date, :name],
    )
  end

  def initialize_form
    @form = OrderStepsForm.new current_order
  end

  def check_order_steps
    return redirect_to wizard_path(:address) unless current_order.addresses.count != 2
    redirect_to wizard_path(:delivery) unless current_order.delivery
    redirect_to wizard_path(:payment) unless current_order.card
  end
end
