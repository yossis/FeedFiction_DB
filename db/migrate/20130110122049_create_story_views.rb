class CreateStoryViews < ActiveRecord::Migration
  def change
    create_table :story_views do |t|
      t.integer :story_id
      t.integer :user_id , default: 0

      t.timestamps
    end
  end
end
