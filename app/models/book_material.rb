class BookMaterial < ApplicationRecord
  belongs_to :book
  belongs_to :material
end
