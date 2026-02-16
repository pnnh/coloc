# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2017_06_15_135142) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_tags", id: :serial, force: :cascade do |t|
    t.integer "article_id"
    t.string "tag", null: false
    t.integer "score", default: 1
    t.index ["article_id"], name: "index_article_tags_on_article_id"
  end

  create_table "articles", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "channel_id"
    t.string "title"
    t.string "content", default: ""
    t.string "tags", default: ""
    t.integer "plus", default: 0
    t.integer "minus", default: 0
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "visible", default: 0, null: false
    t.string "ctype", default: "md", null: false
    t.string "copyright", default: ""
    t.index ["channel_id"], name: "index_articles_on_channel_id"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "channel_follows", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "channel_id"
    t.integer "vote", default: 0
    t.integer "favorite", default: 0
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["channel_id"], name: "index_channel_follows_on_channel_id"
    t.index ["user_id"], name: "index_channel_follows_on_user_id"
  end

  create_table "channel_tags", id: :serial, force: :cascade do |t|
    t.integer "channel_id"
    t.string "tag", null: false
    t.integer "score", default: 1
    t.index ["channel_id"], name: "index_channel_tags_on_channel_id"
  end

  create_table "channels", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.string "description"
    t.string "tags"
    t.string "ctype"
    t.integer "plus", default: 0
    t.integer "minus", default: 0
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "visible", default: 0, null: false
    t.index ["user_id"], name: "index_channels_on_user_id"
  end

  create_table "slogans", id: :serial, force: :cascade do |t|
    t.string "words"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["words"], name: "index_slogans_on_words", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.boolean "admin", default: false
    t.string "remember_token"
    t.string "password_digest"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

end
