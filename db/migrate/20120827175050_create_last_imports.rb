class CreateLastImports < ActiveRecord::Migration
  def change
    create_table :last_imports do |t|
      t.integer :user_id
      t.integer :image_type_id

      t.timestamps
    end
    add_index :last_imports, [:user_id, :image_type_id], unique: true
    add_foreign_key(:last_imports, :users)
    add_foreign_key(:last_imports, :image_types)
  end
end
