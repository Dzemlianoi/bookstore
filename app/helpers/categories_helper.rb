module CategoriesHelper
  def newest_books
    @books.order('created_at DESC').limit(4)
  end

  def bestsellers
    @books.order('name ASC').limit(4)
  end
end
