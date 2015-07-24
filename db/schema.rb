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

ActiveRecord::Schema.define(version: 20150724214149) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "boards", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "trello_id",      null: false
    t.datetime "last_sync_date"
    t.integer  "cards_count",    null: false
    t.string   "url",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "boards", ["cards_count"], name: "index_boards_on_cards_count", using: :btree
  add_index "boards", ["name"], name: "index_boards_on_name", using: :btree

  create_table "cards", force: :cascade do |t|
    t.string   "title",      null: false
    t.integer  "board_id",   null: false
    t.string   "trello_id",  null: false
    t.string   "url",        null: false
    t.float    "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cards", ["board_id"], name: "index_cards_on_board_id", using: :btree
  add_index "cards", ["title"], name: "index_cards_on_title", using: :btree

  create_table "labels", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "card_id",    null: false
    t.string   "type",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "labels", ["card_id"], name: "index_labels_on_card_id", using: :btree
  add_index "labels", ["name"], name: "index_labels_on_name", using: :btree

  add_foreign_key "cards", "boards"
  add_foreign_key "labels", "cards"
end
