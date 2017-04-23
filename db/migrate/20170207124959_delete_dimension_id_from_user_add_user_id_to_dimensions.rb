# frozen_string_literal: true

class DeleteDimensionIdFromUserAddUserIdToDimensions < ActiveRecord::Migration[5.0]
  def change
    remove_reference :books, :book_dimension, foreign_key: true
    add_reference :book_dimensions, :book, foreign_key: true
  end
end
