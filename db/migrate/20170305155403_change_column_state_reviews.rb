class ChangeColumnStateReviews < ActiveRecord::Migration[5.0]
  def change
    change_column :reviews, :state, :string
  end
end
