class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :user_id
      t.string :source_object_id
      t.string :source_url
      t.integer :source_width
      t.integer :source_height
      t.integer :image_type_id
      t.string :url
      t.integer :width
      t.integer :height
      t.boolean :is_proceed, default: false
      t.boolean :is_used , default: false

      t.timestamps
    end
    add_index(:images , :user_id)
    add_index :images, [:source_object_id, :image_type_id], unique: true
    add_foreign_key(:images, :users)
    add_foreign_key(:images, :image_types)
    add_foreign_key(:stories, :images)
  end
end
