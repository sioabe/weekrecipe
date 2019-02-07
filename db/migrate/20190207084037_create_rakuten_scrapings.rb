class CreateRakutenScrapings < ActiveRecord::Migration[5.0]
  def change
    create_table :rakuten_scrapings do |t|
      t. references :recipe, foreign_key: true
      t.string :rakuten_food_name
      t.string :rakuten_food_amount
      t.string :edit_food_name

      t.timestamps
    end
  end
end
