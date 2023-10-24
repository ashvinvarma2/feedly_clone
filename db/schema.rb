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

ActiveRecord::Schema[7.0].define(version: 2023_10_24_073738) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "pub_date"
    t.string "image_url"
    t.string "link"
    t.bigint "rss_feed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rss_feed_id"], name: "index_articles_on_rss_feed_id"
  end

  create_table "board_articles", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.bigint "article_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_board_articles_on_article_id"
    t.index ["board_id"], name: "index_board_articles_on_board_id"
  end

  create_table "boards", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_boards_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "category_rss_feeds", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "rss_feed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_category_rss_feeds_on_category_id"
    t.index ["rss_feed_id"], name: "index_category_rss_feeds_on_rss_feed_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.string "favoritable_type", null: false
    t.bigint "favoritable_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["favoritable_type", "favoritable_id"], name: "index_favorites_on_favoritable"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "options", force: :cascade do |t|
    t.string "title"
    t.bigint "setting_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["setting_id"], name: "index_options_on_setting_id"
  end

  create_table "rss_feeds", force: :cascade do |t|
    t.string "title"
    t.string "link"
    t.string "favicon_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_articles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "article_id", null: false
    t.boolean "marked_as_read", default: false
    t.boolean "read_later", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_user_articles_on_article_id"
    t.index ["user_id"], name: "index_user_articles_on_user_id"
  end

  create_table "user_settings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "setting_id", null: false
    t.bigint "option_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_id"], name: "index_user_settings_on_option_id"
    t.index ["setting_id"], name: "index_user_settings_on_setting_id"
    t.index ["user_id"], name: "index_user_settings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "articles", "rss_feeds"
  add_foreign_key "board_articles", "articles"
  add_foreign_key "board_articles", "boards"
  add_foreign_key "boards", "users"
  add_foreign_key "categories", "users"
  add_foreign_key "category_rss_feeds", "categories"
  add_foreign_key "category_rss_feeds", "rss_feeds"
  add_foreign_key "favorites", "users"
  add_foreign_key "options", "settings"
  add_foreign_key "user_articles", "articles"
  add_foreign_key "user_articles", "users"
  add_foreign_key "user_settings", "options"
  add_foreign_key "user_settings", "settings"
  add_foreign_key "user_settings", "users"
end
