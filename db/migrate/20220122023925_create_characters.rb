class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :race
      t.string :description
      t.integer :age
      t.integer :height
      t.integer :weight
      t.string :sex
      t.string :origin
      t.timestamps null: false
    end
  end
end
