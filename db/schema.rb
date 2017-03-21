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

ActiveRecord::Schema.define(version: 20170320225834) do

  create_table "articles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "tags"
    t.integer  "channel_id"
  end

  create_table "channels", force: :cascade do |t|
    t.integer "user_id"
    t.text    "title"
    t.text    "description"
    t.text    "created_at",  null: false
    t.text    "updated_at",  null: false
    t.text    "tags"
    t.text    "ctype"
  end

  create_table "slogans", force: :cascade do |t|
    t.string   "words"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["words"], name: "index_slogans_on_words", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "admin",           default: false
    t.string   "remember_token"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

end
