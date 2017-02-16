module ApplicationHelper
  def categories
    Category.active
  end

  def empty_cart?
    !cookies.key? :cart
  end

  def purchases_count
    current_order.order_items.count unless current_order.nil?
  end
end
