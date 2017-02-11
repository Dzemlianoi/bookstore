module BookDimensionsHelper
  def total_dimensions(book)
    "H: #{book.book_dimension.height}\" x
     W: #{book.book_dimension.width}\" x
     D: #{book.book_dimension.depth}\""
  end
end