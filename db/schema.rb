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

ActiveRecord::Schema.define(version: 20150204034619) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coaches", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coaches", ["email"], name: "index_coaches_on_email", unique: true, using: :btree
  add_index "coaches", ["reset_password_token"], name: "index_coaches_on_reset_password_token", unique: true, using: :btree

  create_table "lineup_positions", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "player_lineup_id"
    t.integer  "position"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "player_match_count_at_change"
    t.boolean  "restrict_movement"
  end

  create_table "player_lineups", force: :cascade do |t|
    t.string   "title"
    t.integer  "coach_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "player_lineups", ["coach_id"], name: "index_player_lineups_on_coach_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.integer  "win",        default: 0
    t.integer  "loss",       default: 0
    t.integer  "coach_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "players", ["coach_id"], name: "index_players_on_coach_id", using: :btree

end
