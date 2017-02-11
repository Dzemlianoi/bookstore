class BookAuthor < ApplicationRecord
  belongs_to :book
  belongs_to :author

  validates :book_id, :author_id, presence: true
end
