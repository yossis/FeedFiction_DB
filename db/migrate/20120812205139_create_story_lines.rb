class CreateStoryLines < ActiveRecord::Migration
  def change
    create_table :story_lines do |t|
      t.integer :story_id
      t.integer :user_id
      t.integer :order_id, :default =>1
      t.text :line
      t.boolean :is_flagged

      t.timestamps
    end
    add_foreign_key(:story_lines ,:stories)
  end
end
