class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.string :name
      t.text :description
      t.date :date
      t.references :team, null: false
      t.string :uuid, null: false, unqiue: true
      t.timestamps
    end
  end
end
