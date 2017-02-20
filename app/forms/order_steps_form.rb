class OrderStepsForm

  include ActiveModel::Model

  def initialize(order)
    @order = order
  end

  def billing_address
    @order.addresses.find_by(kind: :billing)        ||
      @order.user.addresses.find_by(kind: :billing) ||
        Address.new
  end

  def shipping_address
    @order.addresses.find_by(kind: :shipping) ||
      @order.user.addresses.shipping_address  ||
        Address.new
  end

  def card
    @order.card || Card.new
  end

  def deliveries
    Delivery.all.order('price')
  end

  def create_addresses(billing, shipping)
    if @order.addresses.count != 2
      @order.addresses.create(billing)
      @order.addresses.create(shipping)
    else
      @order.addresses.find_by(kind: :billing).update_attributes(billing)
      @order.addresses.find_by(kind: :shipping).update_attributes(shipping)
    end
  end

  def create_card(credit_card)
    if @order.card
      @order.card.assign_attributes(credit_card)
    else
      @order.create_card(credit_card)
    end
  end

  def create_delivery(delivery_id)
    if Delivery.find_by_id(delivery_id)
      @order.update(delivery_id: delivery_id) and return if @order.delivery
      @order.delivery_id = delivery_id
      @order.recalculate_total
    end
  end

  def save
    @order.save
  end

  def update(step, params)
    case step
      when :address
        params[:shipping_address] = params[:billing_address] if params.has_key? :shipping_check
        create_addresses(params[:billing_address], params[:shipping_address].merge(kind: :shipping))
      when :delivery
        create_delivery(params[:delivery])
      when :payment
        create_card(params[:credit_card])
      else
        @order.create
    end
  end
end