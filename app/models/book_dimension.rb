class BookDimension < ApplicationRecord
  belongs_to :book
  validates_numericality_of :height, :width, :depth, greater_than_or_equal_to: 0
end
