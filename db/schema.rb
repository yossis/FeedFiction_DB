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

ActiveRecord::Schema.define(:version => 20120920130127) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "story_id"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["story_id"], :name => "index_comments_on_story_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "image_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.integer  "user_id"
    t.string   "source_object_id"
    t.string   "source_url"
    t.integer  "source_width"
    t.integer  "source_height"
    t.integer  "image_type_id"
    t.string   "url"
    t.integer  "width"
    t.integer  "height"
    t.boolean  "is_proceed",       :default => false
    t.boolean  "is_used",          :default => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "images", ["source_object_id", "image_type_id"], :name => "index_images_on_source_object_id_and_image_type_id", :unique => true
  add_index "images", ["user_id"], :name => "index_images_on_user_id"

  create_table "last_imports", :force => true do |t|
    t.integer  "user_id"
    t.integer  "image_type_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "last_imports", ["user_id", "image_type_id"], :name => "index_last_imports_on_user_id_and_image_type_id", :unique => true

  create_table "likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "story_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "likes", ["story_id"], :name => "index_likes_on_story_id"
  add_index "likes", ["user_id", "story_id"], :name => "index_likes_on_user_id_and_story_id", :unique => true
  add_index "likes", ["user_id"], :name => "index_likes_on_user_id"

  create_table "notification_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notifications", :force => true do |t|
    t.integer  "notifier_user_id"
    t.integer  "notified_user_id"
    t.integer  "notification_type_id"
    t.integer  "story_id"
    t.string   "object_id"
    t.datetime "date_read"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "notifications", ["notified_user_id", "story_id"], :name => "index_notifications_on_notified_user_id_and_story_id"
  add_index "notifications", ["notified_user_id"], :name => "index_notifications_on_notified_user_id"
  add_index "notifications", ["story_id"], :name => "index_notifications_on_story_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "stories", :force => true do |t|
    t.integer  "user_id"
    t.integer  "image_id"
    t.boolean  "is_complete"
    t.integer  "inappropriate"
    t.integer  "quality"
    t.integer  "story_source_id"
    t.integer  "category_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "story_lines", :force => true do |t|
    t.integer  "story_id"
    t.integer  "user_id"
    t.integer  "order_id",   :default => 1
    t.text     "line"
    t.boolean  "is_flagged"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
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
    t.string   "big_avatar"
    t.string   "cover"
  end

  add_foreign_key "comments", "stories", :name => "comments_story_id_fk"
  add_foreign_key "comments", "users", :name => "comments_user_id_fk"

  add_foreign_key "images", "image_types", :name => "images_image_type_id_fk"
  add_foreign_key "images", "users", :name => "images_user_id_fk"

  add_foreign_key "last_imports", "image_types", :name => "last_imports_image_type_id_fk"
  add_foreign_key "last_imports", "users", :name => "last_imports_user_id_fk"

  add_foreign_key "likes", "stories", :name => "likes_story_id_fk"
  add_foreign_key "likes", "users", :name => "likes_user_id_fk"

  add_foreign_key "notifications", "notification_types", :name => "notifications_notification_type_id_fk"
  add_foreign_key "notifications", "stories", :name => "notifications_story_id_fk"
  add_foreign_key "notifications", "users", :name => "notifications_notified_user_id_fk", :column => "notified_user_id"
  add_foreign_key "notifications", "users", :name => "notifications_notifier_user_id_fk", :column => "notifier_user_id"

  add_foreign_key "stories", "categories", :name => "stories_category_id_fk"
  add_foreign_key "stories", "images", :name => "stories_image_id_fk"
  add_foreign_key "stories", "users", :name => "stories_user_id_fk"

  add_foreign_key "story_lines", "stories", :name => "story_lines_story_id_fk"

end
