class RemoveMaterialNoFromStorages < ActiveRecord::Migration[5.0]
  def change
    remove_column :storages, :material_no, :string
  end
end
