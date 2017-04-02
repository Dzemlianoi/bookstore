class OrderStepsForm
  include ActiveModel::Model

  attr_accessor :billing_address, :shipping_address, :card, :order

  def initialize(order)
    @order = order
    @billing_address ||= form_billing_address
    @shipping_address ||= form_shipping_address
    @card ||= form_card
  end

  def update(step, params)
    case step
      when :address
        @order.update_attributes(use_billing: 0) unless params.has_key? :use_billing
        if params.has_key? :use_billing
          params[:shipping_address] = params[:billing_address]
          @order.update_attribute(:use_billing, 1)
        end
        !!create_addresses(params) & orders_saved?
      when :delivery then create_delivery(params[:delivery])
      when :payment then create_credit_card(params[:card])
      when :confirm then @order.in_confirmation! if params[:success] && !@order.in_confirmation?
    end
  end

  def form_shipping_address
    @order.shipping_address || @order.user.shipping_address || @order.addresses.shipping.new
  end

  def form_billing_address
    @order.billing_address || @order.user.billing_address || @order.addresses.billing.new
  end

  def form_card
    @order.card || @order.build_card
  end

  def deliveries
    Delivery.all.order('price')
  end

  private

  def create_billing(params)
    return @billing_address.update(params) if @order.billing_address
    @billing_address = @order.addresses.billing.create(params)
    @billing_address.persisted?
  end

  def create_shipping(params)
    params = params.merge(kind: :shipping)
    return @shipping_address.update(params) if @order.shipping_address
    @shipping_address = @order.addresses.shipping.create(params)
    @billing_address.persisted?
  end

  def create_credit_card(credit_card)
    @order.card ? @order.card.update(credit_card) : @order.create_card(credit_card)
  end

  def create_delivery(delivery_id)
    return unless Delivery.find_by_id(delivery_id)
    @order.update(delivery_id: delivery_id)
  end

  def create_addresses(params)
    create_billing(params[:billing_address]) && create_shipping(params[:shipping_address])
  end

  def orders_saved?
    @order.addresses.shipping.present? && @order.addresses.billing.present?
  end
end
