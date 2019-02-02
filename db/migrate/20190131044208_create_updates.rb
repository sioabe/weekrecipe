class CreateUpdates < ActiveRecord::Migration[5.0]
  def change
    create_table :updates do |t|
      t.date :update_date

      t.timestamps
    end
  end
end
