# frozen_string_literal: true

class OrderDecorator < Draper::Decorator
  delegate_all
  decorates_association :card, with: CardDecorator
  decorates_association :order_item, with: OrderItemDecorator
end
