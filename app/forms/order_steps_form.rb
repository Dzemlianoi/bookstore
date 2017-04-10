# frozen_string_literal: true

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
      @order.update_attribute(use_billing: 0) unless params.key? :use_billing
      if params.key? :use_billing
        params[:shipping_address] = params[:billing_address]
        @order.update_attribute(:use_billing, 1)
      end
      addresses_saved?(params)
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

  def create_address(type, params)
    params = params.merge(kind: :shipping) if type.eql? 'shipping'
    return instance_variable_get("@#{type}_address").update(params) if @order.send("#{type}_address")
    instance_variable_set("@#{type}_address", @order.addresses.send(type).create(params))
    instance_variable_get("@#{type}_address").persisted?
  end

  def addresses_saved?(params)
    create_addresses(params) & both_addresses_present?
  end

  def create_credit_card(credit_card)
    @order.card ? @order.card.update(credit_card) : @order.create_card(credit_card)
  end

  def create_delivery(delivery_id)
    return unless Delivery.find_by(id: delivery_id)
    @order.update(delivery_id: delivery_id)
  end

  def create_addresses(params)
    create_address('shipping', params[:billing_address]) && create_address('billing', params[:shipping_address])
  end

  def both_addresses_present?
    addresses = @order.addresses
    addresses.shipping.present? & addresses.billing.present?
  end
end
