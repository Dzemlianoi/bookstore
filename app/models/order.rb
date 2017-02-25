class Order < ApplicationRecord
  include AASM

  has_many   :addresses, as: :addressable, dependent: :destroy
  has_many   :order_items, dependent: :destroy,
               after_add: :recalculate_total,
               after_remove: :recalculate_total
  has_many   :books, through: :order_items
  has_one    :coupon
  belongs_to :user
  belongs_to :card
  belongs_to :delivery

  scope :in_progress,       -> { where(aasm_state: [:cart, :filled] ) }

  aasm column: 'aasm_state' do
    state :cart, initial: true
    state :filled, initial: true
    state :in_confirmation, after_enter: :send_confirmation
    state :confirmed, after_enter: :send_confirmation
    state :in_delivery
    state :completed, after_enter: :send_success
    state :canceled


    event :filled do
      transitions from: :cart, to: :filled
    end

    event :in_confirmation do
      transitions from: :filled, to: :in_confirmation
    end

    event :confirmed do
      transitions from: :in_confirmation, to: :confirmaed
    end

    event :to_deliver do
      transitions from: :confirmed, to: :in_delivery
    end

    event :complete do
      transitions from: :in_delivery, to: :completed
    end

    event :cancel do
      transitions from: [:cart, :filled, :in_confirmation, :in_delivery, :confirmed, :completed], to: :canceled
    end
  end

  def send_confirmation
    OrderMailer.confirmation_send(self.user, self).deliver_now
  end

  def recalculate_total(*record)
    self.update_attributes(total_price: total_price)
  end

  def subtotal_price
    self.order_items
        .map { |item| item.book[:price] * item.quantity }
        .inject(&:+)
  end

  def total_price
    return 0.00 if self.order_items.empty?
    price = subtotal_price + delivery_price - discount
    price.positive? ? price : 0.00
  end

  def discount
    self.coupon.nil? ? 0 : self.coupon.discount
  end

  def delivery_price
    self.delivery.nil? ? 0 : self.delivery.price
  end

  def proved?
    self.card && self.delivery && self.addresses.count == 2
  end

  def checkout_state?
    self.cart? || self.filled?
  end

  def final_state?
    self.cart? || self.in_confirmation? || self.filled?
  end
end
