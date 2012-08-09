class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :nick_name
      t.string :avatar
      t.string :email
      t.string :gender
      t.string :oauth_token
      t.datetime :oauth_expires_at

      t.timestamps
    end
  end
end
