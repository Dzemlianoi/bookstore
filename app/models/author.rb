class Author < ApplicationRecord
  has_many :book_authors
  has_many :books, through: :book_authors

  validates :name, :surname, presence: true

  def full_name
    "#{self.name} #{self.surname}"
  end
end
