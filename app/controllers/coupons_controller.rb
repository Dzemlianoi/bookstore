class CouponsController < ApplicationController
  def update
    @coupon = Coupon.find_by(code: coupon_params[:code], order: nil)
    redirect_to :back, alert: t('orders.coupon.not_found') and return if @coupon.nil?
    if lower_then_subtotal?
      @coupon.update(order:current_order)
      flash.keep.notice = t('orders.coupon.added')
    else
      flash.keep.alert = t('orders.coupon.subtotal_greater')
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def coupon_params
    params.require(:coupon).permit(:code)
  end

  def lower_then_subtotal?
    current_order.subtotal_price > @coupon.discount
  end
end
