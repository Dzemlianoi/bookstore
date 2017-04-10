# frozen_string_literal: true

class Order < ApplicationRecord
  include AASM

  has_many   :addresses, as: :addressable, dependent: :destroy
  has_many   :order_items, dependent: :destroy, after_add: :recalculate_total, after_remove: :recalculate_total
  has_many   :books, through: :order_items
  has_one    :coupon, dependent: :destroy
  belongs_to :card, dependent: :destroy
  belongs_to :user
  belongs_to :delivery

  before_create :set_track_number

  validates_uniqueness_of :track_number
  validates_length_of :track_number, maximum: 25

  MY_ORDERS_STATES = %i(in_confirmation in_processing in_delivery completed).freeze

  scope :in_carting, -> { where(aasm_state: %i(cart filled)) }
  scope :after_cart, -> { where(aasm_state: MY_ORDERS_STATES) }
  scope :newest, -> { order('created_at DESC') }
  scope :active, -> { where.not(aasm_state: :canceled) }

  aasm column: 'aasm_state' do
    state :cart, initial: true
    state :filled
    state :in_confirmation, after_enter: :send_confirmation
    state :in_processing, after_enter: :treat_proccessing
    state :in_delivery
    state :completed, after_enter: :send_success
    state :canceled

    event :filled do
      transitions from: :cart, to: :filled
    end

    event :in_confirmation do
      transitions from: :filled, to: :in_confirmation
    end

    event :treat do
      transitions from: :in_confirmation, to: :in_processing
    end

    event :to_deliver do
      transitions from: :in_processing, to: :in_delivery
    end

    event :complete do
      transitions from: :in_delivery, to: :completed
    end

    event :cancel do
      transitions from: %i(cart filled in_confirmation in_delivery in_processing completed), to: :canceled
    end
  end

  rails_admin do
    list do
      field :aasm_state, :state
      include_all_fields
      exclude_fields :confirmation_token, :completed_date
    end
    edit do
      field :aasm_state, :state
      include_all_fields
      exclude_fields :confirmation_token, :completed_date
    end
  end

  def valid_addresses?
    shipping_address && billing_address
  end

  def self.default_sort
    ORDERING[DEFAULT_SORT_KEY]
  end

  def billing_address
    addresses.find_by(kind: 'billing')
  end

  def shipping_address
    addresses.find_by(kind: 'shipping')
  end

  def book_in_order?(book_id)
    !order_items.find_by(book: book_id).nil?
  end

  def subtotal_more_than_discount?(coupon)
    subtotal_price > coupon.discount
  end

  def send_confirmation
    update_attributes(confirmation_token: Devise.friendly_token)
    OrderMailer.confirmation_send(user, self).deliver_now
  end

  def treat_proccessing
    self.confirmation_token = nil
    OrderMailer.treating_send(user, self).deliver_now
  end

  def send_success
    OrderMailer.success_letter(user, self).deliver_later
  end

  def recalculate_total(_)
    update_attributes(total_price: total_price)
  end

  def subtotal_price
    order_items.map { |item| item.book[:price] * item.quantity }.inject(&:+)
  end

  def total_price
    return 0.00 if order_items.empty?
    price = subtotal_price + delivery_price - discount
    price.positive? ? price : 0.00
  end

  def discount
    coupon.nil? ? 0 : coupon.discount
  end

  def delivery_price
    delivery.nil? ? 0 : delivery.price
  end

  def active?
    checkout_state? && !order_items.empty?
  end

  def proved?
    card && delivery && valid_addresses?
  end

  def checkout_state?
    cart? || filled?
  end

  def order_state?
    checkout_state? || in_confirmation?
  end

  def set_track_number
    self.track_number = "R-#{rand(99)}#{Date.today.to_time.to_i}"
  end
end
