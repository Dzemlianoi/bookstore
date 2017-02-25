class Category < ApplicationRecord
  has_many :books

  validates :name, presence: true
  validates :count_books, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :active, -> { where('count_books > 0') }

  def self.default
    Category.find_by_name('Mobile Development')
  end
end
