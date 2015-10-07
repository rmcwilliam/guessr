class AddPlayerAndGameConstraints < ActiveRecord::Migration
  def change
    change_column :games, :player_id, :integer, null: false
    change_column :games, :answer, :integer, null: false
    change_column :games, :turn_count, :integer, default: 0
    change_column :players, :name, :string, null: false
  end
end
