# frozen_string_literal: true

class AddGuestTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :guest_token, :string
  end
end
