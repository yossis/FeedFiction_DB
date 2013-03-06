class AddColumnToRelationShip < ActiveRecord::Migration
  def change
    add_column :relationships, :status, :integer, default: 1
  end
end
