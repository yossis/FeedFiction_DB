class ChangeProceedUrl < ActiveRecord::Migration
  def change
  	rename_column :images, :is_proceed, :image_processed
  	rename_column :images, :url, :image_thumb
  end
end
