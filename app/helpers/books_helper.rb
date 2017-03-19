module BooksHelper
  def sort_present?
    params.key?(:order) && Book::ORDERING[params[:order].to_sym].present?
  end

  def current_sort
    return params[:order] if sort_present?
    Book::DEFAULT_SORT_KEY
  end

  def current_catalog_name
    @category.nil? ? 'All' : @category.name
  end
end
