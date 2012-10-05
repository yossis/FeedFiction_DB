class ChangeSourceUrlName < ActiveRecord::Migration
  def change
    rename_column :images, :source_url, :image_source

  end
end
