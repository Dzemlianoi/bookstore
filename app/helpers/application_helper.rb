module ApplicationHelper
  def categories
    Category.where('count_books > 0').order('count_books DESC')
  end

  def empty_cart?
    !cookies.key? :cart
  end

  def purchase_count
    JSON.parse(cookies[:cart]).length
  end
end
