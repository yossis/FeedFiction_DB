class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :username, uniq: true
      t.string :password
      t.boolean :enable , default: true
      t.string :name

      t.timestamps
    end
    add_index :accounts, [:username ,:password]
  end
end
