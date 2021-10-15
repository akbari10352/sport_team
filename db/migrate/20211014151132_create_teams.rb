class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.references :user, null: false
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
