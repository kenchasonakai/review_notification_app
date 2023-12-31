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

ActiveRecord::Schema[7.1].define(version: 2024_01_03_065640) do
  create_table "authentications", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "group_members", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id", "user_id"], name: "index_group_members_on_group_id_and_user_id", unique: true
    t.index ["group_id"], name: "index_group_members_on_group_id"
    t.index ["user_id"], name: "index_group_members_on_user_id"
  end

  create_table "groups", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "mattermost_channel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "review_requests", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "reviewee_id", null: false
    t.bigint "reviewer_id", null: false
    t.string "url", null: false
    t.text "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_id", null: false
    t.index ["group_id"], name: "index_review_requests_on_group_id"
    t.index ["reviewee_id"], name: "index_review_requests_on_reviewee_id"
    t.index ["reviewer_id"], name: "index_review_requests_on_reviewer_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mattermost_id"
    t.boolean "activated", default: false
    t.integer "role", default: 0
    t.string "github_id"
  end

  add_foreign_key "group_members", "groups"
  add_foreign_key "group_members", "users"
  add_foreign_key "review_requests", "groups"
  add_foreign_key "review_requests", "users", column: "reviewee_id"
  add_foreign_key "review_requests", "users", column: "reviewer_id"
end
