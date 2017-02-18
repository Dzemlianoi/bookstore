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
      shipping_address: [:first_name, :last_name, :address, :city, :zip, :country, :phone, :kind],
      billing_address:  [:first_name, :last_name, :address, :city, :zip, :country, :phone, :kind],
      credit_card:      [:number, :CVV, :expiration_month, :expiration_year, :first_name, :last_name],
      delivery:         [:id]
    )
  end

  def initialize_form
    @form = OrderStepsForm.new current_order
  end

  def check_order_steps
    redirect_to wizard_path(:address) unless current_order.addresses.count != 2
    # return redirect_to wizard_path(:delivery) unless current_order.delivery
    # return redirect_to wizard_path(:payment) unless current_order.credit_card
    # render_wizard
  end
end
