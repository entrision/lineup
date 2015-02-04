class AddRestrictMovementToLineupPositions < ActiveRecord::Migration
  def change
    add_column :lineup_positions, :restrict_movement, :boolean
  end
end
