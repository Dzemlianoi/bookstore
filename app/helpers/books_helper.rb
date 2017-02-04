module BooksHelper

  def all_books
    Category.sum(:count_books)
  end

  def current_sort
    return params[:order] if sort_present?
    default_sort
  end

  def sort_present?
    (params.key? :order) && Book::ORDERING[params[:order].to_sym].present?
  end

  def next_page
    current_limit + 1
  end

  def author_name
    "#{@book.author.name} #{@book.author.surname}"
  end

  def dimensions
    "H: #{@book.height}\" x W:#{@book.width}\" x D: #{@book.depth}\""
  end

  def default_sort
    Book::ORDERING[:titleA]
  end
end
