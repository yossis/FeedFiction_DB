class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :big_avatar, :string
    add_column :users, :cover, :string
  end
end
