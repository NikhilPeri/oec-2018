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

ActiveRecord::Schema.define(version: 20170614140958) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "exchange_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brokers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "token"
    t.bigint "cash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exchanges", force: :cascade do |t|
    t.bigint "day"
    t.integer "update_frequency", limit: 2, default: 3
    t.boolean "live", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holdings", force: :cascade do |t|
    t.bigint "broker_id"
    t.integer "stock_id"
    t.bigint "shares"
    t.bigint "book_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["broker_id"], name: "index_holdings_on_broker_id", unique: true
  end

  create_table "stocks", force: :cascade do |t|
    t.string "ticker"
    t.bigint "price"
    t.bigint "exchange_id"
    t.bigint "annual_vec"
    t.bigint "quarterly_vec"
    t.bigint "monthly_vec"
    t.bigint "week_vec"
    t.bigint "day_vec"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exchange_id"], name: "index_stocks_on_exchange_id", unique: true
  end

  add_foreign_key "holdings", "brokers"
  add_foreign_key "stocks", "exchanges"
end
