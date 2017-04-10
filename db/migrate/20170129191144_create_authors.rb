# frozen_string_literal: true

class CreateAuthors < ActiveRecord::Migration[5.0]
  def change
    create_table :authors do |t|
      t.string :name, presence: true
      t.string :surname, presence: true
      t.timestamps
    end
  end
end
