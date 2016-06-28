class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :description
      t.references :category, foreign_key: true, index: true

      t.timestamps
    end
  end
end
