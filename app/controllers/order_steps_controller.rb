class OrderStepsController < ApplicationController

  before_action :initialize_form

  include Wicked::Wizard
  steps :address, :delivery, :payment, :confirm, :complete

  def show
    redirect_to :root and return unless current_order
    step_to(:complete) and return if (current_order.proved? && !on_step?(:complete))
    check_info_steps and return if current_step? :confirm
    step_to(:confirm) if (!current_order.proved? && on_step?(:complete))
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
      :success,
      shipping_address: [:first_name, :last_name, :address, :city, :zip, :country, :phone, :kind],
      billing_address:  [:first_name, :last_name, :address, :city, :zip, :country, :phone, :kind],
      card:             [:card_number, :cvv, :expire_date, :name]
    )
  end

  def initialize_form
    @form = OrderStepsForm.new current_order
  end

  def on_step? step
    current_step? step
  end

  def step_to step
    redirect_to wizard_path(step)
  end

  def check_info_steps
    step_to(:address) and return unless current_order.addresses.count.eql? 2
    step_to(:delivery) and return unless current_order.delivery
    step_to(:payment) unless current_order.card
  end
end
