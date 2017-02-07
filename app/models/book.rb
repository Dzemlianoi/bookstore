class Book < ApplicationRecord

  mount_uploaders :images, ImagesUploader
  paginates_per 12

  PER_PAGE = 12
  DEFAULT_SORT_KEY = :titleA
  ORDERING = {
    priceA: 'price ASC',
    priceD: 'price DESC',
    new: 'created_at DESC',
    titleA: 'name ASC',
    titleD: 'name DESC'
  }

  belongs_to :category
  belongs_to :author
  has_many :materials, through: :book_materials
  has_many :book_materials
  accepts_nested_attributes_for :materials

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

  def self.default_sort
    ORDERING[DEFAULT_SORT_KEY]
  end
end
