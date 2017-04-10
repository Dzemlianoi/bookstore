# frozen_string_literal: true

module OrderHelper
  def current_sort
    sort_present? ? params[:order].to_s.humanize : I18n.t('books.catalog.all')
  end

  def sort_present?
    return unless params.key? :order
    Order::MY_ORDERS_STATES.include? params[:order].to_sym
  end
end
