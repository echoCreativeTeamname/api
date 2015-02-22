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

ActiveRecord::Schema.define(version: 20150222154025) do

  create_table "authentication_tokens", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "token",      limit: 255
    t.datetime "valid_till"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string  "uuid",        limit: 255
    t.string  "name",        limit: 255
    t.integer "healthclass", limit: 4
  end

  create_table "openinghours", force: :cascade do |t|
    t.integer "store_id",    limit: 4
    t.date    "date"
    t.time    "openingtime"
    t.time    "closingtime"
  end

  create_table "products", force: :cascade do |t|
    t.string   "uuid",          limit: 255
    t.integer  "storechain_id", limit: 4
    t.integer  "ingredient_id", limit: 4
    t.string   "name",          limit: 255
    t.decimal  "price",                     precision: 7, scale: 2
    t.string   "amount",        limit: 255
    t.datetime "lastupdated"
  end

  create_table "recipeingredient", id: false, force: :cascade do |t|
    t.integer "ingredient_id", limit: 4,   null: false
    t.integer "recipe_id",     limit: 4,   null: false
    t.string  "amount",        limit: 255
  end

  create_table "recipes", force: :cascade do |t|
    t.string "uuid",     limit: 255
    t.string "name",     limit: 255
    t.text   "contents", limit: 65535
    t.text   "summary",  limit: 65535
    t.string "imageurl", limit: 255
    t.string "videourl", limit: 255
  end

  create_table "storechains", force: :cascade do |t|
    t.string   "uuid",        limit: 255
    t.string   "name",        limit: 255
    t.integer  "priceclass",  limit: 4
    t.integer  "healthclass", limit: 4
    t.datetime "lastupdated"
  end

  create_table "stores", force: :cascade do |t|
    t.string   "uuid",        limit: 255
    t.integer  "chain_id",    limit: 4
    t.string   "name",        limit: 255
    t.string   "city",        limit: 255
    t.string   "postalcode",  limit: 255
    t.string   "street",      limit: 255
    t.float    "latitude",    limit: 24
    t.float    "longitude",   limit: 24
    t.string   "identifier",  limit: 255
    t.datetime "lastupdated"
  end

  create_table "tables", force: :cascade do |t|
  end

  create_table "users", force: :cascade do |t|
    t.string "uuid",       limit: 255
    t.string "email",      limit: 255
    t.string "password",   limit: 255
    t.string "city",       limit: 255
    t.string "postalcode", limit: 255
    t.string "street",     limit: 255
    t.float  "latitude",   limit: 24
    t.float  "longitude",  limit: 24
  end

  create_table "user_settings", force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.string  "key",     limit: 255
    t.string  "value",   limit: 255
  end

end