class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :story_id

      t.timestamps
    end
    add_index(:likes, :user_id)
    add_index(:likes, :story_id)
    add_index(:likes, [:user_id ,:story_id], unique: true)

    add_foreign_key(:likes, :users)
    add_foreign_key(:likes, :stories)
  end
end
