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

ActiveRecord::Schema[7.0].define(version: 2022_09_22_052524) do
  create_table "heading_states", force: :cascade do |t|
    t.string "name"
    t.boolean "done"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_heading_states_on_user_id"
  end

  create_table "headings", force: :cascade do |t|
    t.string "title"
    t.string "body"
    t.datetime "deadline"
    t.datetime "scheduled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.integer "depth"
    t.integer "headings_count"
    t.integer "heading_state_id"
    t.integer "notebook_id", null: false
    t.datetime "closed_at"
    t.integer "user_id", null: false
    t.string "org_id", null: false
    t.index ["heading_state_id"], name: "index_headings_on_heading_state_id"
    t.index ["notebook_id"], name: "index_headings_on_notebook_id"
    t.index ["org_id"], name: "index_headings_on_org_id"
    t.index ["parent_id"], name: "index_headings_on_parent_id"
    t.index ["user_id"], name: "index_headings_on_user_id"
  end

  create_table "notebooks", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_notebooks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.string "pushover_user_key"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "heading_states", "users"
  add_foreign_key "headings", "notebooks"
  add_foreign_key "headings", "users"
  add_foreign_key "notebooks", "users"
end
