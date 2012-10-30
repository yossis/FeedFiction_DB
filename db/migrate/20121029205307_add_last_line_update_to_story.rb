class AddLastLineUpdateToStory < ActiveRecord::Migration
  def change
    add_column :stories, :last_line_updated_at, :datetime
  end
end
