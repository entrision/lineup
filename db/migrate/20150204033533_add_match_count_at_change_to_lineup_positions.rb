class AddMatchCountAtChangeToLineupPositions < ActiveRecord::Migration
  def change
    add_column :lineup_positions, :player_match_count_at_change, :integer, default: 0
  end
end
