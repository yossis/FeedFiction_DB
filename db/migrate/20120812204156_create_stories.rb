class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :user_id
      t.string :image_url
      t.boolean :is_complete
      t.integer :inappropriate
      t.integer :quality
      t.integer :story_source_id
      t.integer :category_id

      t.timestamps
    end
    add_foreign_key(:stories, :users)
    add_foreign_key(:stories, :categories)
  end
end
