module BooksHelper
  def all_books
    Category.sum(:count_books)
  end
end
