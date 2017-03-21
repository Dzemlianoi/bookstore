module OrderHelper
  def current_sort
    return params[:order].to_s.humanize if sort_present?
    I18n.t('books.catalog.all')
  end

  def sort_present?
    return unless params.key? :order
    Order::MY_ORDERS_STATES.include? params[:order].to_sym
  end
end