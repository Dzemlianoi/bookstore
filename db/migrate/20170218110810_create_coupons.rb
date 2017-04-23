# frozen_string_literal: true

class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.belongs_to :order, index: true
      t.string :code, index: true, unique: true
      t.integer :discount
      t.timestamps
    end
  end
end
