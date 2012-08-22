class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :story_id
      t.text :comment

      t.timestamps
    end

    add_index(:comments , :user_id)
    add_index(:comments , :story_id)

   	add_foreign_key(:comments, :users)
   	add_foreign_key(:comments, :stories)
  end
end
