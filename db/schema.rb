# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_25_172909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accumulation_tips", force: :cascade do |t|
    t.bigint "tips_id", null: false
    t.bigint "accumulation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accumulation_id"], name: "index_accumulation_tips_on_accumulation_id"
    t.index ["tips_id"], name: "index_accumulation_tips_on_tips_id"
  end

  create_table "accumulations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_accumulations_on_user_id"
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
  end

  create_table "tips", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "rating"
    t.string "outcome"
    t.string "body"
    t.bigint "match_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_id"], name: "index_tips_on_match_id"
    t.index ["user_id"], name: "index_tips_on_user_id"
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
  end

  add_foreign_key "accumulation_tips", "accumulations"
  add_foreign_key "accumulation_tips", "tips", column: "tips_id"
  add_foreign_key "accumulations", "users"
  add_foreign_key "tips", "matches"
  add_foreign_key "tips", "users"
end
