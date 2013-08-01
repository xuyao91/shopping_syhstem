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

ActiveRecord::Schema.define(:version => 20120116005903) do

  create_table "admins", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.boolean  "deleted",                                 :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

  create_table "attachments", :force => true do |t|
    t.integer  "owner_id"
    t.string   "file_name"
    t.string   "file_path"
    t.string   "type"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres", :force => true do |t|
    t.string   "name"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "opinions", :force => true do |t|
    t.integer  "review_id"
    t.integer  "user_id"
    t.boolean  "opinion",    :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.integer  "count",           :default => 1
    t.integer  "user_address_id"
    t.boolean  "deleted",         :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "total_price"
    t.boolean  "flag",            :default => false, :null => false
  end

  create_table "pro_collects", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.integer  "genre_id"
    t.string   "name"
    t.text     "describe"
    t.string   "price"
    t.boolean  "deleted",      :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sub_genre_id"
    t.integer  "quantity",     :default => 100
  end

  create_table "reviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.text     "content"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sub_genres", :force => true do |t|
    t.string   "sub_name"
    t.integer  "genre_id"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_addresses", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "address"
    t.string   "code"
    t.string   "tel"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "crypted_password",          :limit => 40
    t.string   "email"
    t.string   "gender"
    t.integer  "age"
    t.string   "tel"
    t.boolean  "deleted",                                 :default => false, :null => false
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

end
