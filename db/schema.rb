# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171112094930) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "group_assignments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "group"
    t.date     "assign_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "group_assignments", ["user_id"], name: "index_group_assignments_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.boolean  "active",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "users", ["phone"], name: "index_users_on_phone", unique: true, using: :btree

  add_foreign_key "group_assignments", "users"
end
