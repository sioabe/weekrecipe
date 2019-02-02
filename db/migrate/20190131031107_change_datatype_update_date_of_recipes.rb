class ChangeDatatypeUpdateDateOfRecipes < ActiveRecord::Migration[5.0]
  def change
    change_column :recipes, :update_date, :DateTime
  end
end
