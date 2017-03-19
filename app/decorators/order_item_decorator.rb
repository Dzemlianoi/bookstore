class OrderItemDecorator < Draper::Decorator
  delegate_all
  decorates_association :book, with: BookDecorator
end