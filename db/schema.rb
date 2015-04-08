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

ActiveRecord::Schema.define(version: 20150408140514) do

  create_table "authentication_tokens", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "token",      limit: 255
    t.datetime "valid_till"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string  "uuid",        limit: 255
    t.string  "name",        limit: 255
    t.integer "healthclass", limit: 4,   default: 1
    t.string  "imageurl",    limit: 255
  end

  add_index "ingredients", ["uuid"], name: "index_ingredients_on_uuid", unique: true, using: :btree

  create_table "openinghours", force: :cascade do |t|
    t.integer "store_id",    limit: 4
    t.date    "date"
    t.time    "openingtime"
    t.time    "closingtime"
  end

  add_index "openinghours", ["date"], name: "index_openinghours_on_date", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "uuid",          limit: 255
    t.integer  "storechain_id", limit: 4
    t.integer  "ingredient_id", limit: 4
    t.string   "name",          limit: 255
    t.decimal  "price",                     precision: 7, scale: 2
    t.string   "amount",        limit: 255
    t.datetime "lastupdated"
    t.string   "identifier",    limit: 255
  end

  add_index "products", ["identifier"], name: "index_products_on_identifier", using: :btree
  add_index "products", ["uuid"], name: "index_products_on_uuid", unique: true, using: :btree

  create_table "recipeingredients", force: :cascade do |t|
    t.integer "recipe_id",     limit: 4
    t.integer "ingredient_id", limit: 4
    t.string  "amount",        limit: 255
  end

  add_index "recipeingredients", ["ingredient_id"], name: "index_recipeingredients_on_ingredient_id", using: :btree
  add_index "recipeingredients", ["recipe_id"], name: "index_recipeingredients_on_recipe_id", using: :btree

  create_table "recipes", force: :cascade do |t|
    t.string  "uuid",        limit: 255
    t.string  "name",        limit: 255
    t.text    "contents",    limit: 65535
    t.text    "summary",     limit: 65535
    t.string  "imageurl",    limit: 255
    t.string  "videourl",    limit: 255
    t.string  "dish_type",   limit: 255
    t.integer "portions",    limit: 4
    t.float   "cookingtime", limit: 24
  end

  add_index "recipes", ["uuid"], name: "index_recipes_on_uuid", unique: true, using: :btree

  create_table "recipes_users", id: false, force: :cascade do |t|
    t.integer "recipe_id", limit: 4, null: false
    t.integer "user_id",   limit: 4, null: false
  end

  add_index "recipes_users", ["recipe_id"], name: "index_recipes_users_on_recipe_id", using: :btree
  add_index "recipes_users", ["user_id"], name: "index_recipes_users_on_user_id", using: :btree

  create_table "storechains", force: :cascade do |t|
    t.string   "uuid",        limit: 255
    t.string   "name",        limit: 255
    t.integer  "priceclass",  limit: 4
    t.integer  "healthclass", limit: 4,   default: 1
    t.datetime "lastupdated"
  end

  add_index "storechains", ["uuid"], name: "index_storechains_on_uuid", unique: true, using: :btree

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

  add_index "stores", ["uuid"], name: "index_stores_on_uuid", unique: true, using: :btree

  create_table "stores_users", id: false, force: :cascade do |t|
    t.integer "store_id", limit: 4, null: false
    t.integer "user_id",  limit: 4, null: false
  end

  add_index "stores_users", ["store_id"], name: "index_stores_users_on_store_id", using: :btree
  add_index "stores_users", ["user_id"], name: "index_stores_users_on_user_id", using: :btree

  create_table "user_settings", force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.string  "key",     limit: 255
    t.string  "value",   limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string "uuid",            limit: 255
    t.string "email",           limit: 255
    t.string "password_digest", limit: 255
    t.string "city",            limit: 255
    t.string "postalcode",      limit: 255
    t.string "street",          limit: 255
    t.float  "latitude",        limit: 24
    t.float  "longitude",       limit: 24
  end

  add_index "users", ["uuid"], name: "index_users_on_uuid", unique: true, using: :btree

end
