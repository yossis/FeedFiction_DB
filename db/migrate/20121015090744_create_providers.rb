class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.integer :user_id
      t.string :provider_name
      t.string :uid
      t.string :name
      t.string :oauth_token
      t.string :oauth_expires_at

      t.timestamps
    end

    add_foreign_key(:providers, :users)
    add_index(:providers, :user_id)
  end
end
