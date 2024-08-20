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

ActiveRecord::Schema[7.1].define(version: 2024_08_19_171447) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chatgpt_responses", force: :cascade do |t|
    t.text "content"
    t.bigint "diary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_chatgpt_responses_on_diary_id"
  end

  create_table "diaries", force: :cascade do |t|
    t.text "content"
    t.date "date"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "chatgpt_response"
    t.string "image"
    t.json "layout"
    t.json "images"
    t.index ["user_id"], name: "index_diaries_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_chatgpt_use", precision: nil
    t.string "activation_state"
    t.string "activation_token"
    t.datetime "activation_token_expires_at"
    t.boolean "admin"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "chatgpt_responses", "diaries"
  add_foreign_key "diaries", "users"
end
