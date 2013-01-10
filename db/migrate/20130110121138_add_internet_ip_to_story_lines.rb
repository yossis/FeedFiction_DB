class AddInternetIpToStoryLines < ActiveRecord::Migration
  def change
    add_column :story_lines, :ip, :string
  end
end
