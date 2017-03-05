class OrderStepsForm
  include ActiveModel::Model

  attr_accessor :billing_address, :shipping_address, :card

  def initialize(order)
    @order = order
    @billing_address ||= form_billing_address
    @shipping_address ||= form_shipping_address
    @card ||= form_card
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

  def create_billing(params)
    byebug
    @order.billing_address ?
        @billing_address.update(params) :
        @order.addresses.billing.create(params)
  end

  def create_shipping(params)
    @order.shipping_address ?
        @shipping_address.update(params) :
        @order.addresses.shipping.create(params)
  end

  def create_credit_card(credit_card)
    @order.card ? @order.card.update(credit_card) : @order.create_card(credit_card)
  end

  def create_delivery(delivery_id)
    return unless Delivery.find_by_id(delivery_id)
    @order.update(delivery_id: delivery_id)
  end

  def update(step, params)
    case step
      when :address
        params[:shipping_address] = params[:billing_address] if params.has_key? :shipping_check
        create_billing(params[:billing_address]) && create_shipping(params[:shipping_address])
      when :delivery
        create_delivery(params[:delivery])
      when :payment
        create_credit_card(params[:card])
      when :confirm
        @order.in_confirmation! if params[:success] && !@order.in_confirmation?
    end
  end
end