class CreateBookMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :book_materials do |t|
      t.belongs_to :book, index: true
      t.belongs_to :material, index: true
    end
  end
end
