class CreateAdminFakers < ActiveRecord::Migration
  def change
    create_table :admin_fakers do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
