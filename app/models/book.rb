class Book < ApplicationRecord
  belongs_to :category
  validates :name, :price, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :publication_year, length:  { is: 4 }
  validates :publication_year, numericality: { only_integer: true, greater_than: 1000 }
  validates :description, length:  { maximum: 1000 }

  after_save :increment_books_count
  after_destroy :decrement_books_count

  private

  def increment_books_count
    self.category.increment!(:count_books)
  end

  def decrement_books_count
    self.category.decrement!(:count_books)
  end
end