module OrderHelper
  def current_sort
    return params[:order] if sort_present?
    Order::DEFAULT_SORT_KEY
  end

  def sort_present?
    (params.key? :order) && Order::ORDERING[params[:order].to_sym].present?
  end
end