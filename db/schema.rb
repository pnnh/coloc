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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170603210550) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "channel_id"
    t.string   "title"
    t.string   "content"
    t.string   "tags"
    t.integer  "plus"
    t.integer  "minus"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visible",    default: 0,    null: false
    t.string   "ctype",      default: "md", null: false
    t.string   "copyright",  default: "",   null: false
  end

  create_table "channel_follows", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "channel_id"
    t.integer  "vote",       default: 0
    t.integer  "favorite",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["channel_id"], name: "index_channel_follows_on_channel_id", using: :btree
    t.index ["user_id"], name: "index_channel_follows_on_user_id", using: :btree
  end

  create_table "channels", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "description"
    t.string   "tags"
    t.string   "ctype"
    t.integer  "plus"
    t.integer  "minus"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "visible",     default: 0, null: false
  end

  create_table "slogans", force: :cascade do |t|
    t.string   "words"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["words"], name: "index_slogans_on_words", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "admin",           default: false
    t.string   "remember_token"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

end
