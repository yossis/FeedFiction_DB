class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.integer :story_id , null: false
      t.integer :flag_reason_id
      t.string :reason
      t.integer :reporter_user_id

      t.timestamps
    end
	add_index(:flags, :story_id)
    
    add_foreign_key(:flags, :stories)
    add_foreign_key(:flags, :flag_reasons)
    add_foreign_key(:flags, :users , column: 'reporter_user_id')

  end
end
