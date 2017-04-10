# frozen_string_literal: true

class CouponsController < ApplicationController
  authorize_resource

  def create
    @coupon = Coupon.find_by(code: coupon_params[:code], order: nil)
    redirect_to order_items_path, alert: t('coupon.not_found') and return unless @coupon
    redirect_to order_items_path, alert: t('coupon.subtotal_greater') and return unless coupon_cheaper_than_subtotal?
    redirect_to order_items_path, notice: t('coupon.added') if @coupon.update(order: current_order)
  end

  private

  def coupon_cheaper_than_subtotal?
    current_order.subtotal_more_than_discount? @coupon
  end

  def coupon_params
    params.require(:coupon).permit(:code)
  end
end
