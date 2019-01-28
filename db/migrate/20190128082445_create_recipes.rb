class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.string :rakuten_recipe_id
      t.string :title
      t.string :url
      t.string :food_image_url
      t.text :materials
      t.string :category_id

      t.timestamps
    end
  end
end
