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

ActiveRecord::Schema[7.0].define(version: 2022_06_17_001457) do
  create_table "heading_states", force: :cascade do |t|
    t.string "name"
    t.boolean "done"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
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
    t.index ["heading_state_id"], name: "index_headings_on_heading_state_id"
    t.index ["notebook_id"], name: "index_headings_on_notebook_id"
    t.index ["parent_id"], name: "index_headings_on_parent_id"
  end

  create_table "notebooks", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "headings", "notebooks"
end
