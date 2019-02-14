class AddNoToFoods < ActiveRecord::Migration[5.0]
  def change
    add_column :foods, :no, :string
  end
end
