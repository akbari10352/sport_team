class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.references :team, null: false
      t.string :name, null: false
      t.string :uuid, null: false, unique: true
      t.json :details
      t.timestamps
    end
  end
end
