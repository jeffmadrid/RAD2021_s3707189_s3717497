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

ActiveRecord::Schema.define(version: 2021_05_24_024003) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bag_items", force: :cascade do |t|
    t.integer "quantity"
    t.boolean "purchased"
    t.bigint "item_variant_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_variant_id"], name: "index_bag_items_on_item_variant_id"
    t.index ["user_id"], name: "index_bag_items_on_user_id"
  end

  create_table "collection_items", force: :cascade do |t|
    t.integer "category"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_collection_items_on_item_id"
  end

  create_table "item_images", force: :cascade do |t|
    t.bigint "item_id"
    t.string "image_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_images_on_item_id"
  end

  create_table "item_variants", force: :cascade do |t|
    t.integer "colour"
    t.integer "size"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_variants_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "image_link"
    t.float "price"
    t.date "arrival_date"
    t.integer "popularity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "value"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "saved_items", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_saved_items_on_item_id"
    t.index ["user_id"], name: "index_saved_items_on_user_id"
  end

  create_table "tag_items", force: :cascade do |t|
    t.integer "tag"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_tag_items_on_item_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.string "secret"
    t.string "profile_image"
    t.integer "checkouts"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "visitors", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bag_items", "item_variants"
  add_foreign_key "bag_items", "users"
  add_foreign_key "collection_items", "items"
  add_foreign_key "item_images", "items"
  add_foreign_key "item_variants", "items"
  add_foreign_key "ratings", "users"
  add_foreign_key "saved_items", "items"
  add_foreign_key "saved_items", "users"
  add_foreign_key "tag_items", "items"
end
