class OrderStepsController < ApplicationController
  include Wicked::Wizard
  before_action :go_root_unless_order
  before_action :initialize_form

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    step_to(:complete) and return if last_active_order.in_confirmation? && !on_step?(:complete)
    render and return if last_active_order.in_confirmation? && on_step?(:complete)
    check_info_steps if on_step? :confirm
    step_to(:confirm) if on_step?(:complete) && !last_active_order.in_processing? && !last_active_order.in_confirmation?
  end

  def update
    @updating_result = @form.update(step, order_params)
    step_to next_step and return if @updating_result.eql?(true)
    render 'order_steps/show', step: step
  end

  private

  def go_root_unless_order
    unless last_active_order && (last_active_order(&:checkout_state?) || last_active_order(&:in_confirmation?))
      redirect_to :root, alert: t('flashes.error.no_order')
    end
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

  def confirmation_params

  end

  def initialize_form
    @form ||= OrderStepsForm.new last_active_order
  end

  def on_step? step
    current_step? step
  end

  def step_to step
    redirect_to wizard_path(step)
  end

  def check_info_steps
    step_to(:address) and return unless last_active_order.addresses.count.eql? 2
    step_to(:delivery) and return unless last_active_order.delivery
    step_to(:payment) and return unless last_active_order.card
    last_active_order.filled! unless last_active_order.filled?
  end
end
