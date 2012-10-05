class CreateAlbumTypes < ActiveRecord::Migration
  def change
    create_table :album_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
