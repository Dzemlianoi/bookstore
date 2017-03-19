class BookDecorator < Draper::Decorator
  delegate_all

  def all_authors
    object.authors.map { |author| author.decorate.full_name }.join(', ')
  end

  def first_sentence_description
    object.description.split('.')[0]
  end

  def front_image
    return object.images.first.attachment.url unless object.images.first.nil?
    ActionController::Base.helpers.image_url('default_book.jpg')
  end

  def all_materials
    object.materials.map(&:name).join(', ')
  end

  def total_dimensions
    "H: #{object.book_dimension.height}\"x
     W: #{object.book_dimension.width}\" x
     D: #{object.book_dimension.depth}\""
  end
end