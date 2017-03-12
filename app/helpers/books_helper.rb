module BooksHelper
  def sort_present?
    params.key?(:order) && Book::ORDERING[params[:order].to_sym].present?
  end

  def current_sort
    return params[:order] if sort_present?
    Book::DEFAULT_SORT_KEY
  end

  def current_catalog_name
    @category.nil? ? 'All' : @category.name
  end

  def get_image(book)
    return book.images.first.attachment.url unless book.images.first.nil?
    ActionController::Base.helpers.image_url("default_book.jpg")
  end

  def first_sentence_description(book)
    truncate(book.description.split('.')[0], length: 30)
  end
end
