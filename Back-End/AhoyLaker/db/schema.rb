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

ActiveRecord::Schema.define(version: 20150709000101) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dinings", force: :cascade do |t|
    t.string   "name"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "location"
  end

  add_index "dinings", ["organization_id"], name: "index_dinings_on_organization_id", using: :btree

  create_table "hours", force: :cascade do |t|
    t.string   "title"
    t.string   "data"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "dining_id"
    t.string   "dining_type"
  end

  create_table "menus", force: :cascade do |t|
    t.string   "section_title"
    t.string   "items"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "dining_id"
    t.string   "dining_type"
  end

  create_table "offers", force: :cascade do |t|
    t.string   "url"
    t.string   "doc"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name"
    t.string   "image_url"
    t.string   "description"
    t.string   "promo_details"
    t.string   "coupon_code"
  end

  add_index "offers", ["organization_id"], name: "index_offers_on_organization_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.boolean  "enabled"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "org_type"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "user_sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "organization_id"
    t.boolean  "is_admin"
  end

  add_foreign_key "dinings", "organizations"
  add_foreign_key "offers", "organizations"
end
