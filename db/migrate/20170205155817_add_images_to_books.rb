# frozen_string_literal: true

class AddImagesToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :images, :json
  end
end
