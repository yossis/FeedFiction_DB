class AddViewsToStories < ActiveRecord::Migration
  def change
    add_column :stories, :view_count, :integer , default: 0
  end
end
