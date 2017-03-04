class OrderStepsController < ApplicationController
  include Wicked::Wizard

  before_action :go_root_unless_order
  before_action :initialize_form

  steps :fast_sign, :address, :delivery, :payment, :confirm, :complete

  def show
    case step
      when :fast_sign then next_step and return if current_user
      when :address, :delivery, :payment
        step_to :fast_sign and return unless current_user
        step_to :complete and return if last_active_order.in_confirmation?
      when :confirm then return check_info_steps
      when :complete
        step_to :fast_sign and return unless current_user
        step_to :confirm and return unless last_active_order.in_confirmation?
    end
    render_wizard
  end

  def update
    @updating_result = @form.update(step, order_params)
    step_to next_step and return if @updating_result.eql?(true)
    render_wizard
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

  def initialize_form
    @form ||= OrderStepsForm.new last_active_order
  end

  def step_to step
    redirect_to wizard_path(step)
  end

  def check_info_steps
    step_to :fast_sign and return unless current_user
    step_to :address and return unless last_active_order.addresses.count.eql? 2
    step_to :delivery and return unless last_active_order.delivery
    step_to :payment and return unless last_active_order.card
    last_active_order.filled! unless last_active_order.filled? || last_active_order.in_confirmation?
    render_wizard
  end
end
