class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :shipping_address_id, index: true
      t.integer :billing_address_id, index: true
      t.datetime :completed_date
      t.decimal  :total_price, precision: 5, scale: 2
      t.timestamps
    end
    add_reference :orders, :user, index: true, foreign_key: true
  end
end
