class CreatePlayerLineups < ActiveRecord::Migration
  def change
    create_table :player_lineups do |t|
      t.string :title
      t.references :coach, index: true

      t.timestamps null: false
    end
  end
end
