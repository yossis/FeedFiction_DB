class AddStatusToStories < ActiveRecord::Migration
  def change
    add_column :stories, :status, :integer , default: 1

    add_index(:stories, :status)
  end
end
