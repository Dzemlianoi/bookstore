class AddTrackNumberToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :track_number, :string
  end
end
