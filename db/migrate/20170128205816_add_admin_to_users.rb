# frozen_string_literal: true

class AddAdminToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_admin, :boolean
  end
end
