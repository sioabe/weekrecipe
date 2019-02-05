class CreateSupervisors < ActiveRecord::Migration[5.0]
  def change
    create_table :supervisors do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
