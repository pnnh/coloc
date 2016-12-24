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

ActiveRecord::Schema.define(version: 20160830154432) do

  create_table "channels", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "contents", force: :cascade do |t|
    t.string   "parent_type"
    t.integer  "parent_id"
    t.string   "child_type"
    t.integer  "child_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["child_type", "child_id"], name: "index_contents_on_child_type_and_child_id"
    t.index ["parent_type", "parent_id"], name: "index_contents_on_parent_type_and_parent_id"
  end

  create_table "items", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.string   "slug"
    t.string   "markup"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["slug"], name: "index_items_on_slug"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_tags_on_title"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "slug"
    t.boolean  "admin",           default: false
    t.string   "remember_token"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_token"], name: "index_users_on_remember_token"
    t.index ["slug"], name: "index_users_on_slug"
  end

end
