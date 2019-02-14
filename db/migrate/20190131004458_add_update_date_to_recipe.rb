class AddUpdateDateToRecipe < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :update_date, :DateTime
  end
end
