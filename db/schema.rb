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

ActiveRecord::Schema.define(version: 2019_11_20_184227) do

  create_table "comments", force: :cascade do |t|
    t.string "commenter"
    t.text "body"
    t.integer "micropost_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["micropost_id"], name: "index_comments_on_micropost_id"
  end

  create_table "microposts", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.string "description"
    t.string "priority"
    t.string "type_issue"
    t.integer "assignee_id"
    t.string "status", default: "New"
    t.integer "votes", default: 0
    t.integer "watchers", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "micropost_id"
    t.index ["micropost_id"], name: "index_votes_on_micropost_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  create_table "watchers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "micropost_id"
    t.index ["micropost_id"], name: "index_watchers_on_micropost_id"
    t.index ["user_id"], name: "index_watchers_on_user_id"
  end

  add_foreign_key "comments", "microposts"
  add_foreign_key "votes", "microposts"
  add_foreign_key "votes", "users"
  add_foreign_key "watchers", "microposts"
  add_foreign_key "watchers", "users"
end
