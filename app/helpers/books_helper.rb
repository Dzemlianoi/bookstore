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

  def get_image(book)
    if book.images.first.nil?
      ActionController::Base.helpers.image_url("default_book.jpg")
    else
      book.images.first.attachment.url
    end
  end

  def get_images(book)
    return unless book.images
    book.images
  end

  def first_sentence_description(book)
    book.description.split('.')[0]
  end
end
