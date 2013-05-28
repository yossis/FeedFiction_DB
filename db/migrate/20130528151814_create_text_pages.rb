class CreateTextPages < ActiveRecord::Migration
  def change
    create_table :text_pages do |t|
      t.integer :page_type , default: 0
      t.string :name

      t.timestamps
    end
  end
end
