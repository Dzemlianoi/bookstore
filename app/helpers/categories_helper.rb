module CategoriesHelper
  def newest_books
    @books.newest.limit(3)
  end

  def bestsellers
    @books.bestsellers.limit(3)
  end
end
