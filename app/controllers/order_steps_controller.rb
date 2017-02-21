class OrderStepsController < ApplicationController

  before_action :go_root_unless_order
  before_action :initialize_form

  include Wicked::Wizard
  steps :address, :delivery, :payment, :confirm, :complete

  def show
    step_to(:complete) and return if last_order.confirmed?
    check_info_steps if on_step? :confirm
    if on_step? :confirm
      return check_info_steps
    end
    step_to(:confirm) if last_order.in_confirmation?
    step_to(:confirm) if on_step?(:complete) && !last_order.in_confirmation?
  end

  def update
    @form.update(step, order_params)
    render_wizard @form
  end

  private

  def go_root_unless_order
    redirect_to :root unless last_order.in_progress? || last_order
  end


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
    step_to(:address) and return unless last_order.addresses.count.eql? 2
    step_to(:delivery) and return unless last_order.delivery
    step_to(:payment) and return unless last_order.card
    last_order.filled! unless last_order.filled? || last_order.in_confirmation?
  end
end
