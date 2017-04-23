# frozen_string_literal: true

class RemoveAuthorIdFromBooks < ActiveRecord::Migration[5.0]
  def change
    remove_reference :books, :author, index: true, foreign_key: true
  end
end
