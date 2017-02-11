module ApplicationHelper
  def categories
    Category.active
  end

  def empty_cart?
    !cookies.key? :cart
  end

  def purchase_count
    JSON.parse(cookies[:cart]).length
  end
end
