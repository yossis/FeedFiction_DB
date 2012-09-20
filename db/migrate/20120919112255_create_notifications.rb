class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :notifier_user_id
      t.integer :notified_user_id
      t.integer :notification_type_id
      t.integer :story_id
      t.string :item_id
      t.datetime :date_read

      t.timestamps
    end
    add_index(:notifications, :notified_user_id)
    add_index(:notifications, :story_id)
    add_index(:notifications, [:notified_user_id ,:story_id])

    add_foreign_key(:notifications, :notification_types)
    add_foreign_key(:notifications, :users , column: 'notifier_user_id')
    add_foreign_key(:notifications, :users , column: 'notified_user_id')
    add_foreign_key(:notifications, :stories)
  end
end
