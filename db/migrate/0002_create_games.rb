class CreateGames < ActiveRecord::Migration
  def up
    create_table :games do |t|
      t.integer :player_id
      t.integer :answer
      t.integer :last_guess
      t.integer :turn_count
    end
  end
end
