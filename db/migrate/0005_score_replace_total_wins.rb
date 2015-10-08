class ScoreReplaceTotalWins < ActiveRecord::Migration

  def up
    rename_column :players, :total_wins, :score
  end

  def down
    remove_column :players, :score 
  end
end