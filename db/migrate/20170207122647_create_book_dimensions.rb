class CreateBookDimensions < ActiveRecord::Migration[5.0]
  def change
    create_table :book_dimensions do |t|
      t.decimal :height, precision: 4, scale: 2 , default: 0.00
      t.decimal :width, precision: 4, scale: 2, default: 0.00
      t.decimal :depth, precision: 4, scale: 2, default: 0.00
      t.timestamps
    end
  end
end
