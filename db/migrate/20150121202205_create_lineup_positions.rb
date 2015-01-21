class CreateLineupPositions < ActiveRecord::Migration
  def change
    create_table :lineup_positions do |t|
      t.references :player
      t.references :player_lineup
      t.integer    :position

      t.timestamps null: false
    end
  end
end
