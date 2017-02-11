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

  def current_catalog_name
    @category.nil? ? 'All' : @category.name
  end

  def first_sentence_description(book)
    book.description.split('.')[0]
  end
end
