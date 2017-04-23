# frozen_string_literal: true

class OrderStepsController < ApplicationController
  include Wicked::Wizard

  before_action :go_root_unless_order, :initialize_form

  steps :fast_sign, :address, :delivery, :payment, :confirm, :complete

  def show
    case step
    when :fast_sign then check_fast_sign and return
    when :address, :delivery, :payment then check_filling_steps and return
    when :confirm then check_confirm_step and return
    else check_complete_step
    end
  end

  def update
    @updating_result = @form.update(step, order_params)
    step_to next_step and return if @updating_result.eql?(true)
    render_wizard
  end

  private

  def order_params
    params.permit(:use_billing,
                  :delivery,
                  :success,
                  :editing,
                  shipping_address: %i[first_name last_name address city zip country phone kind],
                  billing_address:  %i[first_name last_name address city zip country phone kind],
                  card:             %i[card_number cvv expire_date name])
  end

  def initialize_form
    @form ||= OrderStepsForm.new last_active_order
  end

  def go_root_unless_order
    return if last_active_order(&:order_state?)
    redirect_to :root, alert: t('flashes.error.no_order')
  end

  def step_to(step)
    redirect_to wizard_path(step)
  end

  def check_fast_sign
    next_step and return if current_user
    render_wizard
  end

  def check_filling_steps
    step_to :fast_sign and return unless current_user
    step_to :complete and return if last_active_order.in_confirmation?
    step_to :confirm and return if last_active_order.filled? && !order_params[:editing].present?
    render_wizard
  end

  def check_confirm_step
    step_to :fast_sign and return unless current_user
    step_to :address and return unless last_active_order.valid_addresses?
    step_to :delivery and return unless last_active_order.delivery
    step_to :payment and return unless last_active_order.card
    last_active_order.filled! unless last_active_order.filled? || last_active_order.in_confirmation?
    render_wizard
  end

  def check_complete_step
    step_to :fast_sign and return unless current_user
    step_to :confirm and return unless last_active_order.in_confirmation?
    render_wizard
  end
end
