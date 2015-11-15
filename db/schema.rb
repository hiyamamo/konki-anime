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

ActiveRecord::Schema.define(version: 20151115070347) do

  create_table "details", force: true do |t|
    t.string   "tv_station"
    t.datetime "started_at"
    t.integer  "program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "details", ["program_id"], name: "index_details_on_program_id"

  create_table "programs", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "season_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vote",       default: 0
  end

  add_index "programs", ["season_id"], name: "index_programs_on_season_id"

  create_table "seasons", force: true do |t|
    t.string   "value",                      null: false
    t.boolean  "current",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "users", force: true do |t|
    t.integer  "uid"
    t.string   "name"
    t.text     "img_url"
    t.string   "screen_name"
    t.text     "access_token"
    t.text     "access_token_secret"
    t.string   "provider"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "watch_lists", force: true do |t|
    t.integer  "user_id"
    t.integer  "detail_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
