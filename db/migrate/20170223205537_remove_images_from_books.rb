# frozen_string_literal: true

class RemoveImagesFromBooks < ActiveRecord::Migration[5.0]
  def change
    remove_column :books, :images
  end
end
