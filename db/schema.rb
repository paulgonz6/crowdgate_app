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

ActiveRecord::Schema.define(version: 20150513155754) do

  create_table "bookings", force: true do |t|
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.integer  "tailgate_id"
    t.string   "stripe_token"
    t.integer  "quantity"
    t.decimal  "stripe_fees",       precision: 10, scale: 4, default: 0.0
    t.decimal  "total_price",       precision: 10, scale: 4, default: 0.0
    t.decimal  "donation_amount",   precision: 10, scale: 4, default: 0.0
    t.integer  "buyer_id"
    t.string   "email"
    t.string   "phone"
    t.boolean  "checkout_as_guest"
    t.decimal  "ticket_sales",      precision: 10, scale: 4, default: 0.0
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.string   "time"
    t.string   "venue"
    t.string   "city"
    t.string   "state"
    t.string   "ap_id"
    t.string   "api_modified"
    t.integer  "away_team_id"
    t.integer  "home_team_id"
    t.string   "type"
    t.datetime "date"
  end

  create_table "reviews", force: true do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "review"
    t.integer  "rating"
    t.integer  "tailgate_id"
    t.integer  "user_id"
  end

  create_table "tailgates", force: true do |t|
    t.string  "name"
    t.text    "description"
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
    t.string  "image_1"
    t.string  "image_2"
    t.string  "image_3"
    t.string  "image_4"
    t.string  "type"
    t.integer "original_size"
    t.integer "current_size"
    t.integer "host_id"
    t.boolean "live",                 default: true
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.string   "headline"
    t.string   "background_image"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "logo"
    t.string   "color"
    t.string   "sport"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.string   "name"
    t.string   "image"
    t.boolean  "admin"
    t.string   "stripe_customer_id"
    t.boolean  "host_status"
    t.text     "description"
    t.string   "email",                                          default: "",  null: false
    t.string   "encrypted_password",                             default: "",  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                  default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "phone"
    t.decimal  "sales_percentage",       precision: 6, scale: 5, default: 0.8
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
