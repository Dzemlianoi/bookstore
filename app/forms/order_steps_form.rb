class OrderStepsForm

  include ActiveModel::Model

  def initialize(order)
    @order = order
  end

  def billing_address
    @order.addresses.find_by(kind: :billing)        ||
      @order.user.addresses.find_by(kind: :billing) ||
        Address.new(kind: :billing)
  end

  def shipping_address
    @order.addresses.find_by(kind: :shipping) ||
      @order.user.addresses.find_by(kind: :shipping) ||
        Address.new(kind: :shipping)
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
      @order.card.update_attributes(credit_card)
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

  def confirm_order success
    @order.update_attributes(verified: true) if success
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
        create_card(params[:card])
      when :confirm
        confirm_order(params[:success])
      else
        @order.create
    end
  end
end