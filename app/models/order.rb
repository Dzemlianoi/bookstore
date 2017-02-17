class Order < ApplicationRecord
  # include AASM
  #
  # aasm do
  #   state :cart, initial: true
  # end
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :order_items, dependent: :destroy,
           after_add: :recalculate_total,
           after_remove: :recalculate_total
  has_many :books, through: :order_items
  belongs_to :user

  private

  def recalculate_total(item)
    self.update(total_price: new_total_sum)
  end

  def new_total_sum
    self.order_items
        .map { |item| item.book[:price] * item.quantity }
        .reduce(0, :+)
  end

end
