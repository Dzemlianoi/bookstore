module BooksHelper
  def all_books
    Category.sum(:count_books)
  end

  def current_sort
    return params[:order] if sort_present?
    Book::DEFAULT_SORT_KEY
  end

  def sort_present?
    (params.key? :order) && Book::ORDERING[params[:order].to_sym].present?
  end

  def dimensions
    "H: #{@book.height}\" x W:#{@book.width}\" x D: #{@book.depth}\""
  end

  def max_books_of_cat
    @category.nil? ? all_books : @category.count_books
  end

  def current_catalog_name
    @category.nil? ? 'All' : @category.name
  end

  def last_page?
    (max_books_of_cat - limiting) <= 0
  end
end
