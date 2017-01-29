class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      # Four book’s photos, Author(s), Materials
      t.string :name
      t.text :description
      t.string :quantity, default: 0
      t.integer :publication_year, min: 1000
      t.decimal :price, precision: 5, scale: 2, default: 0.00
      t.decimal :height, precision: 2, scale: 2 , default: 0.00
      t.decimal :width, precision: 2, scale: 2, default: 0.00
      t.decimal :depth, precision: 2, scale: 2, default: 0.00
      t.timestamps
    end
    add_reference :books, :category, index: true, foreign_key: true
    add_reference :books, :author, index: true, foreign_key: true
  end
end
