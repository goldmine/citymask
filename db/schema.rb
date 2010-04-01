# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100401051837) do

  create_table "albums", :force => true do |t|
    t.integer  "user_id"
    t.integer  "photos_count", :default => 0,    :null => false
    t.string   "name"
    t.text     "description"
    t.boolean  "public",       :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "entry_id"
    t.integer  "user_id"
    t.string   "guest_name"
    t.string   "guest_email"
    t.string   "guest_url"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entries", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.integer  "comments_count", :default => 0, :null => false
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forums", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "topics_count", :default => 0, :null => false
    t.integer  "posts_count",  :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.integer  "user_id"
    t.integer  "album_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "content_type", :limit => 100
    t.string   "filename"
    t.string   "path"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
  end

  create_table "posts", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.text     "about_me"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id", :null => false
    t.integer "user_id", :null => false
  end

  create_table "topics", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.integer  "posts_count", :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",        :limit => 64,                    :null => false
    t.string   "email",           :limit => 128,                   :null => false
    t.string   "hashed_password", :limit => 64
    t.boolean  "enabled",                        :default => true, :null => false
    t.datetime "last_login_at"
    t.integer  "topics_count",                   :default => 0,    :null => false
    t.integer  "posts_count",                    :default => 0,    :null => false
    t.string   "blog_title"
    t.boolean  "enable_comments",                :default => true, :null => false
    t.integer  "entries_count",                  :default => 0,    :null => false
    t.integer  "albums_count",                   :default => 0,    :null => false
    t.integer  "photos_count",                   :default => 0,    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
