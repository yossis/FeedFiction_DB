class CreateFlagReasons < ActiveRecord::Migration
  def change
    create_table :flag_reasons do |t|
      t.string :name

      t.timestamps
    end
  end
end
