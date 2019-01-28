class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :rakuten_category_id
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
