# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120820070412) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "story_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stories", :force => true do |t|
    t.integer  "user_id"
    t.string   "image_url"
    t.boolean  "is_compleate"
    t.integer  "inappropreate"
    t.integer  "quality"
    t.integer  "story_source_id"
    t.integer  "category_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "story_lines", :force => true do |t|
    t.integer  "story_id"
    t.integer  "user_id"
    t.integer  "order_id"
    t.string   "line"
    t.boolean  "is_flagged"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "nick_name"
    t.string   "avatar"
    t.string   "email"
    t.string   "gender"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "login_count",      :default => 0
  end

  add_foreign_key "stories", "categories", :name => "stories_category_id_fk"
  add_foreign_key "stories", "users", :name => "stories_user_id_fk"

  add_foreign_key "story_lines", "stories", :name => "story_lines_story_id_fk"

end
