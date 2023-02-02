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

ActiveRecord::Schema.define(version: 2023_02_02_045708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accumulation_tips", force: :cascade do |t|
    t.bigint "tip_id", null: false
    t.bigint "accumulation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accumulation_id"], name: "index_accumulation_tips_on_accumulation_id"
    t.index ["tip_id"], name: "index_accumulation_tips_on_tip_id"
  end

  create_table "accumulations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "approved_at"
    t.string "outcome", default: "pending"
    t.index ["user_id"], name: "index_accumulations_on_user_id"
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "bookmakers", force: :cascade do |t|
    t.string "link"
    t.string "title"
    t.string "description"
    t.string "image_url"
    t.string "subtitle"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "approved_at"
  end

  create_table "matches", force: :cascade do |t|
    t.string "home_team_name"
    t.string "away_team_name"
    t.string "score"
    t.datetime "start_at"
    t.integer "fixture_id"
    t.string "league"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fixture_id"], name: "index_matches_on_fixture_id"
  end

  create_table "offers", force: :cascade do |t|
    t.string "link"
    t.string "title"
    t.string "description"
    t.string "image_url"
    t.string "subtitle"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "approved_at"
  end

  create_table "points", force: :cascade do |t|
    t.integer "value"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "pointable_type", null: false
    t.bigint "pointable_id", null: false
    t.index ["pointable_type", "pointable_id"], name: "index_points_on_pointable_type_and_pointable_id"
    t.index ["user_id"], name: "index_points_on_user_id"
  end

  create_table "tips", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "rating"
    t.string "outcome"
    t.string "body"
    t.bigint "match_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "bet"
    t.decimal "odd", precision: 5, scale: 2
    t.string "mongo_id"
    t.datetime "approved_at"
    t.string "bet_category"
    t.index ["match_id"], name: "index_tips_on_match_id"
    t.index ["user_id"], name: "index_tips_on_user_id"
  end

  create_table "user_point_counters", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "awarded_at"
    t.integer "point", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_point_counters_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "username"
    t.string "access_token"
    t.string "token_id"
    t.string "provider_id"
    t.string "avatar_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "approved_provider_at"
  end

  add_foreign_key "accumulation_tips", "accumulations"
  add_foreign_key "accumulation_tips", "tips"
  add_foreign_key "accumulations", "users"
  add_foreign_key "points", "users"
  add_foreign_key "tips", "matches"
  add_foreign_key "tips", "users"
  add_foreign_key "user_point_counters", "users"
end
