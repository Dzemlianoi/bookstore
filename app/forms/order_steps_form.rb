class OrderStepsForm
  include ActiveModel::Model

  attr_accessor :billing_address, :shipping_address, :card

  def initialize(order)
    @order = order
    @billing_address = @order.billing_address
    @shipping_address = @order.shipping_address
    @card = @order.card
  end

  def form_shipping_address
    @shipping_address || @order.user.shipping_address || Address.new(kind: :shipping)
  end

  def form_billing_address
    @billing_address || @order.user.billing_address || Address.new(kind: :billing)
  end

  def form_card
    @card || Card.new
  end

  def deliveries
    Delivery.all.order('price')
  end

  def create_address(params)
    current_address = @order.addresses.find_by_kind(params[:kind])
    current_address ? current_address.update(params) : @order.addresses.create(params)
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
        create_address(params[:billing_address]) && create_address(params[:shipping_address])
      when :delivery
        create_delivery(params[:delivery])
      when :payment
        create_credit_card(params[:card])
      when :confirm
        @order.in_confirmation! if (params[:success])
    end
  end
end