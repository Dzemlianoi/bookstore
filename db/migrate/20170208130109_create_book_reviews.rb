class CreateBookReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :book_reviews do |t|
      t.belongs_to :book, index: true
      t.belongs_to :user, index: true
      t.string :comment_text, null: false, default: ''
      t.boolean :approved?, default: false, null: false
      t.integer :rating
    end
  end
end
