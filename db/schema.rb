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

ActiveRecord::Schema.define(version: 20150115205222) do

  create_table "events", force: true do |t|
    t.string "name"
    t.string "date"
    t.string "time"
    t.string "venue"
    t.string "city"
    t.string "state"
    t.string "ap_id"
    t.string "api_modified"
  end

  create_table "tailgates", force: true do |t|
    t.string  "name"
    t.text    "description"
    t.integer "size"
    t.integer "price"
    t.string  "affiliation"
    t.boolean "reserved_parking"
    t.boolean "grill"
    t.boolean "tent"
    t.string  "tailgate_start_time"
    t.boolean "tailgate_during_game"
    t.boolean "chairs"
    t.boolean "table"
    t.boolean "bevs_alcohol"
    t.boolean "bevs_non_alcohol"
    t.boolean "tailgate_games"
    t.boolean "food"
    t.integer "event_id"
  end

end
