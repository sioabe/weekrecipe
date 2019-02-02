class CreateFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :hiragana
      t.string :katakana
      t.string :kanzi
      t.string :other1
      t.string :other2
      t.string :other3

      t.timestamps
    end
  end
end
