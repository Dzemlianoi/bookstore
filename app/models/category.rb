class Category < ApplicationRecord
  has_many :books

  validates_presence_of :name
  validates_numericality_of :count_books,
                            only_integer: true,
                            greater_than_or_equal_to: 0

  scope :active, -> { where('count_books > 0') }

  def self.default
    Category.find_by(name: 'Mobile Development')
  end
end
