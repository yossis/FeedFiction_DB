class AddAlbumTypeIdToImage < ActiveRecord::Migration
  def change
    add_column :images, :album_type_id, :integer
    rename_column :images, :is_used, :in_cdn

    add_foreign_key(:images, :album_types)
  end
end
