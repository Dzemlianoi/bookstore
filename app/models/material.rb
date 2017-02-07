class Material < ApplicationRecord
  has_many :books, through: :book_materials
  has_many :book_materials
end
