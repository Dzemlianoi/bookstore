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

ActiveRecord::Schema.define(version: 20170208130109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "book_authors", force: :cascade do |t|
    t.integer "book_id"
    t.integer "author_id"
    t.index ["author_id"], name: "index_book_authors_on_author_id", using: :btree
    t.index ["book_id"], name: "index_book_authors_on_book_id", using: :btree
  end

  create_table "book_dimensions", force: :cascade do |t|
    t.decimal  "height",     precision: 4, scale: 2, default: "0.0"
    t.decimal  "width",      precision: 4, scale: 2, default: "0.0"
    t.decimal  "depth",      precision: 4, scale: 2, default: "0.0"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.integer  "book_id"
    t.index ["book_id"], name: "index_book_dimensions_on_book_id", using: :btree
  end

  create_table "book_materials", force: :cascade do |t|
    t.integer "book_id"
    t.integer "material_id"
    t.index ["book_id"], name: "index_book_materials_on_book_id", using: :btree
    t.index ["material_id"], name: "index_book_materials_on_material_id", using: :btree
  end

  create_table "books", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "quantity",                                 default: "0"
    t.integer  "publication_year"
    t.decimal  "price",            precision: 5, scale: 2, default: "0.0"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.integer  "category_id"
    t.json     "images"
    t.index ["category_id"], name: "index_books_on_category_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "count_books", default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["name"], name: "index_categories_on_name", unique: true, using: :btree
  end

  create_table "materials", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "book_id"
    t.integer "user_id"
    t.string  "comment_text", default: "",    null: false
    t.string  "name",         default: "",    null: false
    t.boolean "approved",     default: false, null: false
    t.integer "rating"
    t.index ["book_id"], name: "index_reviews_on_book_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "role_name"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "book_dimensions", "books"
  add_foreign_key "books", "categories"
end
