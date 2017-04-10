# frozen_string_literal: true

module BooksHelper
  def category_sort_present?
    params.key?(:order) && Book::ORDERING[params[:order].to_sym].present?
  end

  def current_sorting
    return params[:order] if category_sort_present?
    Book::DEFAULT_SORT_KEY
  end

  def current_catalog_name
    @category.nil? ? 'All' : @category.name
  end
end
