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

ActiveRecord::Schema.define(version: 20150129160558) do

  create_table "bookings", force: true do |t|
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "user_id"
    t.boolean  "valid_transaction", default: false
    t.integer  "tailgate_id"
    t.string   "stripe_token"
    t.integer  "quantity"
    t.integer  "amount"
  end

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

  create_table "reviews", force: true do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "review"
    t.integer  "rating"
    t.integer  "reviewer_id"
    t.integer  "tailgate_id"
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
    t.integer "user_id"
    t.string  "image_1"
    t.string  "image_2"
    t.string  "image_3"
    t.string  "image_4"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "name"
    t.string   "email"
    t.string   "image"
    t.string   "password_digest"
    t.boolean  "admin"
    t.string   "stripe_customer_id"
    t.boolean  "host_status"
    t.text     "description"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
