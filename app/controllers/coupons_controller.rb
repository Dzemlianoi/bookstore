class CouponsController < ApplicationController
  authorize_resource

  def create
    @coupon = Coupon.find_by(code: coupon_params[:code], order: nil)
    redirect_to :back, alert: t('coupon.not_found') and return if @coupon.nil?
    if current_order.subtotal_more_than_discount? @coupon
      @coupon.update(order:current_order)
      flash.keep.notice = t('coupon.added')
    else
      flash.keep.alert = t('coupon.subtotal_greater')
    end
    go_back
  end

  private

  def coupon_params
    params.require(:coupon).permit(:code)
  end
end
