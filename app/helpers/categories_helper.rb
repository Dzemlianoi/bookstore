module CategoriesHelper
  def newest_books
    @books.newest.limit(4)
  end

  def bestsellers
    @books.bestsellers.limit(4)
  end
end
