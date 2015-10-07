class CreatePlayers < ActiveRecord::Migration
  def up
    create_table :players do |t|
      t.string  :name
      t.integer :total_wins
    end
  end

  def down
    drop_table :players
  end
end
