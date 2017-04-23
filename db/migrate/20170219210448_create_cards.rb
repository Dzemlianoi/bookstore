# frozen_string_literal: true

class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :card_number, presence: true
      t.string :name, presence: true
      t.string :expire_date, presence: true
      t.string :cvv, presence: true
      t.timestamps
    end
  end
end
