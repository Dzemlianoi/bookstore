class BookMaterial < ApplicationRecord
  belongs_to :book
  belongs_to :material

  validates :book_id, :material_id, presence: true
end
