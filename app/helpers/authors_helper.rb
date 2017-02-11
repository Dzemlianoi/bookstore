module AuthorsHelper
  def full_name(author)
    "#{author.name} #{author.surname}"
  end

  def all_authors(book)
    book.authors.map { |author| full_name(author) }.join(', ')
  end
end
