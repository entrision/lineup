class AddMatchCountAtChangeToLineupPositions < ActiveRecord::Migration
  def change
    add_column :lineup_positions, :player_match_count_at_change, :integer
  end
end
