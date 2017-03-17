class Author < ApplicationRecord
  has_many :book_authors
  has_many :books, through: :book_authors

  validates :name, :surname, presence: true, format: { with: /\A[-A-z'`]+\z/i }
end
