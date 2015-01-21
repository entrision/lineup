class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.integer :win, default: 0
      t.integer :loss, default: 0

      t.timestamps null: false
    end
  end
end
