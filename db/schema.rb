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

ActiveRecord::Schema.define(version: 20170414110902) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "title"
    t.text     "body"
    t.string   "subject"
    t.integer  "user_id",          null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "delivery_payment_cost_types", force: :cascade do |t|
    t.string "value"
    t.string "description"
  end

  create_table "delivery_payment_types", force: :cascade do |t|
    t.string "value"
    t.string "description"
  end

  create_table "followings", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["followed_id"], name: "index_followings_on_followed_id", using: :btree
    t.index ["follower_id", "followed_id"], name: "index_followings_on_follower_id_and_followed_id", unique: true, using: :btree
    t.index ["follower_id"], name: "index_followings_on_follower_id", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "enabled",     default: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_groups_on_user_id", using: :btree
  end

  create_table "groups_users", id: false, force: :cascade do |t|
    t.integer "group_id"
    t.integer "user_id"
    t.index ["group_id", "user_id"], name: "index_groups_users_on_group_id_and_user_id", unique: true, using: :btree
    t.index ["group_id"], name: "index_groups_users_on_group_id", using: :btree
    t.index ["user_id"], name: "index_groups_users_on_user_id", using: :btree
  end

  create_table "order_items", force: :cascade do |t|
    t.string   "name"
    t.integer  "quantity"
    t.float    "cost"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "status"
    t.integer  "purchase_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.date     "end_date"
    t.integer  "status"
    t.integer  "group_id"
    t.integer  "owner_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "city_id"
    t.string   "catalogue_link"
    t.float    "commission",                    default: 0.0
    t.string   "address"
    t.string   "apartment"
    t.integer  "delivery_payment_type_id"
    t.integer  "delivery_payment_cost_type_id"
    t.index ["city_id"], name: "index_purchases_on_city_id", using: :btree
    t.index ["delivery_payment_cost_type_id"], name: "index_purchases_on_delivery_payment_cost_type_id", using: :btree
    t.index ["delivery_payment_type_id"], name: "index_purchases_on_delivery_payment_type_id", using: :btree
  end

  create_table "recipes", force: :cascade do |t|
    t.string   "name"
    t.string   "short"
    t.text     "description"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "owner_id"
    t.integer  "love_id",            default: 0
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "resource_id"
    t.string   "resource_type"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "", null: false
    t.integer  "role_id"
    t.string   "phone"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  add_foreign_key "groups", "users"
  add_foreign_key "purchases", "cities"
  add_foreign_key "purchases", "delivery_payment_cost_types"
  add_foreign_key "purchases", "delivery_payment_types"
end
