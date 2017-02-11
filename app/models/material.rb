class Material < ApplicationRecord
  has_many :book_materials
  has_many :books, through: :book_materials

  validates :name, presence: true
end
