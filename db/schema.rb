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

ActiveRecord::Schema.define(version: 2019_09_30_194521) do

  create_table "coffee_shops", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.datetime "opens_at"
    t.datetime "closes_at"
    t.float "cost_per_size"
  end

  create_table "psl", force: :cascade do |t|
    t.integer "coffee_shop_id"
    t.integer "user_id"
    t.string "dairy_opt"
    t.string "sweetener"
    t.integer "sweetness"
    t.boolean "iced?"
    t.boolean "whip?"
    t.integer "shots"
    t.integer "size"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "name"
    t.string "home_location"
    t.string "current_location"
    t.float "wallet"
    t.integer "psl_quota"
  end

end
