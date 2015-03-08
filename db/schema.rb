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

ActiveRecord::Schema.define(version: 20150306052709) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "break_videos", force: :cascade do |t|
    t.string   "title"
    t.text     "summary"
    t.string   "guid"
    t.string   "source"
    t.string   "thumbnail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  add_index "break_videos", ["slug"], name: "index_break_videos_on_slug", using: :btree

  create_table "buzzfeed_articles", force: :cascade do |t|
    t.string   "title"
    t.text     "summary"
    t.string   "source"
    t.string   "guid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "thumbnail"
  end

  create_table "chive_articles", force: :cascade do |t|
    t.string   "title"
    t.string   "guid"
    t.string   "source"
    t.text     "summary"
    t.string   "categories"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "thumbnail"
  end

  create_table "cracked_articles", force: :cascade do |t|
    t.string   "title"
    t.text     "summary"
    t.string   "source"
    t.string   "guid"
    t.string   "thumbnail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jokes", force: :cascade do |t|
    t.text     "title"
    t.text     "content"
    t.string   "source",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "guid",       limit: 255
    t.string   "slug"
  end

  add_index "jokes", ["slug"], name: "index_jokes_on_slug", using: :btree

  create_table "memebase_articles", force: :cascade do |t|
    t.string   "title"
    t.string   "categories"
    t.string   "guid"
    t.string   "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "thumbnail"
  end

  create_table "reddit_funny_pictures", force: :cascade do |t|
    t.string   "title"
    t.string   "source"
    t.string   "guid"
    t.string   "thumbnail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "content"
    t.string   "slug"
  end

  add_index "reddit_funny_pictures", ["slug"], name: "index_reddit_funny_pictures_on_slug", using: :btree

end
