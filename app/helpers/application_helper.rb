module ApplicationHelper
  def active_categories
    Category.active
  end

  def empty_cart?
    current_user ? current_user.orders.empty? : true
  end

  def purchases_count
    current_order.order_items.count unless current_order.nil?
  end
end
