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

ActiveRecord::Schema[7.0].define(version: 2024_01_30_040028) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "kana"
    t.bigint "prefecture_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prefecture_id"], name: "index_cities_on_prefecture_id"
  end

  create_table "event_attendances", force: :cascade do |t|
    t.bigint "event_id", comment: "参加申込イベント"
    t.bigint "user_id", comment: "イベント申込者"
    t.string "status", null: false, comment: "ステータス"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_attendances_on_event_id"
    t.index ["user_id"], name: "index_event_attendances_on_user_id"
  end

  create_table "events", comment: "イベント", force: :cascade do |t|
    t.bigint "master_id", comment: "イベント主催者"
    t.string "zipcode_id", comment: "イベント場所の郵便番号"
    t.string "name", null: false, comment: "イベント名"
    t.string "address", null: false, comment: "イベント場所住所"
    t.text "description", null: false, comment: "詳細"
    t.integer "price", null: false, comment: "参加費用"
    t.integer "people_limit", comment: "人数制限"
    t.datetime "held_at", null: false, comment: "開催日時"
    t.datetime "deadline_at", null: false, comment: "申込締切日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["master_id"], name: "index_events_on_master_id"
    t.index ["zipcode_id"], name: "index_events_on_zipcode_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name"
    t.string "kana"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "raw_zipcodes", force: :cascade do |t|
    t.string "code"
    t.string "prefecture"
    t.string "prefecture_kana"
    t.string "city"
    t.string "city_kana"
    t.string "town"
    t.string "town_kana"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "league_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_teams_on_league_id"
  end

  create_table "towns", force: :cascade do |t|
    t.string "name"
    t.string "kana"
    t.bigint "city_id"
    t.string "zipcode_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_towns_on_city_id"
    t.index ["zipcode_id"], name: "index_towns_on_zipcode_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.integer "age", null: false
    t.string "gender", null: false
    t.bigint "favorite_team_id"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["favorite_team_id"], name: "index_users_on_favorite_team_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "zipcodes", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cities", "prefectures"
  add_foreign_key "event_attendances", "events"
  add_foreign_key "event_attendances", "users"
  add_foreign_key "events", "users", column: "master_id"
  add_foreign_key "events", "zipcodes"
  add_foreign_key "teams", "leagues"
  add_foreign_key "towns", "cities"
  add_foreign_key "towns", "zipcodes"
  add_foreign_key "users", "teams", column: "favorite_team_id"
end
