class ChangeEmailUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :email, :string, default:'', null: true
  end
end
