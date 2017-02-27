class Book < ApplicationRecord

  scope :newest,      -> { order('created_at DESC') }
  scope :bestsellers, -> { order('name ASC') }

  belongs_to :category
  has_one    :book_dimension
  has_many   :book_materials
  has_many   :book_authors
  has_many   :reviews
  has_many   :materials, through: :book_materials
  has_many   :authors, through: :book_authors
  has_many   :order_items
  has_many   :orders, through: :order_items
  has_many   :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images
  accepts_nested_attributes_for :book_dimension

  paginates_per 12

  DEFAULT_SORT_KEY = :titleA
  ORDERING = {
    priceA: 'price ASC',
    priceD: 'price DESC',
    new:    'created_at DESC',
    titleA: 'name ASC',
    titleD: 'name DESC'
  }

  validates_presence_of :name, :price, :publication_year
  validates_numericality_of :publication_year, only_integer: true, greater_than: 0
  validates_length_of :description, maximum: 1000
  validates_format_of :price, with: /\A\d+(?:\.\d{0,2})?\z/
  validates_format_of :name, with: /\A[-a-z !?,.@:=&'"]+\z/i
  validate :valid_year

  after_save :increment_books_count
  after_destroy :decrement_books_count

  private

  def valid_year
    if Date.current.year < publication_year.to_i
      errors.add(:publication_year, t('flashes.error.wrong_year'))
    end
  end

  def increment_books_count
    category.increment!(:count_books)
  end

  def decrement_books_count
    category.decrement!(:count_books)
  end

  def self.default_sort
    ORDERING[DEFAULT_SORT_KEY]
  end
end
