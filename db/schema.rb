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

ActiveRecord::Schema.define(version: 20190301092315) do

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "rakuten_category_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "foods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "hiragana"
    t.string   "katakana"
    t.string   "kanzi"
    t.string   "other1"
    t.string   "other2"
    t.string   "other3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "no"
  end

  create_table "likes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_likes_on_recipe_id", using: :btree
    t.index ["user_id"], name: "index_likes_on_user_id", using: :btree
  end

  create_table "list_recipes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "list_id"
    t.integer  "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_list_recipes_on_list_id", using: :btree
    t.index ["recipe_id"], name: "index_list_recipes_on_recipe_id", using: :btree
  end

  create_table "lists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "list_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lists_on_user_id", using: :btree
  end

  create_table "rakuten_scrapings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "recipe_id"
    t.string   "rakuten_food_name"
    t.string   "rakuten_food_amount"
    t.string   "edit_food_name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["recipe_id"], name: "index_rakuten_scrapings_on_recipe_id", using: :btree
  end

  create_table "recipes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "rakuten_recipe_id"
    t.string   "title"
    t.string   "url"
    t.string   "food_image_url"
    t.text     "materials",         limit: 65535
    t.string   "category_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.datetime "update_date"
  end

  create_table "storage_lists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_storage_lists_on_recipe_id", using: :btree
    t.index ["user_id"], name: "index_storage_lists_on_user_id", using: :btree
  end

  create_table "storages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "recipe_id"
    t.integer  "food_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "rakuten_scraping_id"
    t.index ["food_id"], name: "index_storages_on_food_id", using: :btree
    t.index ["rakuten_scraping_id"], name: "index_storages_on_rakuten_scraping_id", using: :btree
    t.index ["recipe_id"], name: "index_storages_on_recipe_id", using: :btree
  end

  create_table "supervisors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "updates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "update_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "picture"
  end

  add_foreign_key "likes", "recipes"
  add_foreign_key "likes", "users"
  add_foreign_key "list_recipes", "lists"
  add_foreign_key "list_recipes", "recipes"
  add_foreign_key "lists", "users"
  add_foreign_key "rakuten_scrapings", "recipes"
  add_foreign_key "storage_lists", "recipes"
  add_foreign_key "storage_lists", "users"
  add_foreign_key "storages", "foods"
  add_foreign_key "storages", "rakuten_scrapings"
  add_foreign_key "storages", "recipes"
end
