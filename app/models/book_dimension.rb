class BookDimension < ApplicationRecord
  belongs_to :book

  validates :height, :width, :depth, numericality: { greater_than_or_equal_to: 0 }
end
