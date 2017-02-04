class Category < ApplicationRecord
  has_many :books
  validates :name, presence: true

  def self.default_category
    Category.find_by_name('Mobile Development')
  end
end
