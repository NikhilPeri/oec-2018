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

ActiveRecord::Schema.define(version: 20180127035037) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.bigint "exchange_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exchange_id"], name: "index_admins_on_exchange_id"
  end

  create_table "brokers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "token"
    t.bigint "cash"
    t.bigint "exchange_id"
    t.integer "historical_portfolio", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exchange_id"], name: "index_brokers_on_exchange_id"
  end

  create_table "exchanges", force: :cascade do |t|
    t.bigint "day"
    t.integer "update_frequency", limit: 2
    t.boolean "live"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holdings", force: :cascade do |t|
    t.bigint "broker_id"
    t.bigint "stock_id"
    t.bigint "shares", default: 0
    t.bigint "book_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["broker_id"], name: "index_holdings_on_broker_id"
    t.index ["stock_id"], name: "index_holdings_on_stock_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "ticker"
    t.bigint "price"
    t.bigint "exchange_id"
    t.float "annual_vec"
    t.float "intermediate_vec"
    t.float "daily_vec"
    t.integer "historical_price", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exchange_id"], name: "index_stocks_on_exchange_id"
  end

  add_foreign_key "admins", "exchanges"
  add_foreign_key "brokers", "exchanges"
  add_foreign_key "holdings", "brokers"
  add_foreign_key "holdings", "stocks"
  add_foreign_key "stocks", "exchanges"
end
