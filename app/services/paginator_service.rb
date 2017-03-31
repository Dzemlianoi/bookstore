class PaginatorService
  def initialize(params, category)
    @page = params.has_key?(:page) ? params[:page].to_i : 1
    @category = category
  end

  def limiting
    @page * Book::DEFAULT_PER
  end

  def next_page
    @page + 1
  end

  def total_books_by_category
    @category.nil? ? Category.sum(:count_books) : @category.count_books
  end

  def last_page?
    (total_books_by_category - limiting) <= 0
  end
end
