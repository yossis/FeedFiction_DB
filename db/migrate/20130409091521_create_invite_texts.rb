class CreateInviteTexts < ActiveRecord::Migration
  def change
    create_table :invite_texts do |t|
      t.string :title
      t.string :content
      t.integer :story_type

      t.timestamps
    end
  end
end
