# frozen_string_literal: true

class RebuildDimensionsFromBooks < ActiveRecord::Migration[5.0]
  def change
    remove_column :books, :height
    remove_column :books, :width
    remove_column :books, :depth
    add_reference :books, :book_dimension, foreign_key: true
  end
end
