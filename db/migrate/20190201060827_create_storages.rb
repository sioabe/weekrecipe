class CreateStorages < ActiveRecord::Migration[5.0]
  def change
    create_table :storages do |t|
      t.references :recipe, foreign_key: true
      t.references :food, foreign_key: true
      t.string :material_no

      t.timestamps
    end
  end
end
