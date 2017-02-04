module ApplicationHelper
  def categories
    Category.where('count_books > 0').order('count_books DESC')
  end
end
