module BooksHelper

  def all_books
    Category.sum(:count_books)
  end

  def current_sort
    return params[:order] if sort_present?
    Book.default_sort
  end

  def sort_present?
    (params.key? :order) && Book::ORDERING[params[:order].to_sym].present?
  end

  def next_page
    current_limit + 1
  end
end
