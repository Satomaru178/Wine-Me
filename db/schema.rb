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

ActiveRecord::Schema.define(version: 2020_08_20_045623) do

  create_table "brands", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "origin", null: false
    t.text "explain", null: false
    t.string "year"
    t.string "value"
    t.integer "scene"
    t.integer "taste"
    t.integer "likes_count"
    t.bigint "user_id", null: false
    t.bigint "type_id"
    t.bigint "variety_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_brands_on_name"
    t.index ["type_id"], name: "index_brands_on_type_id"
    t.index ["user_id"], name: "index_brands_on_user_id"
    t.index ["variety_id"], name: "index_brands_on_variety_id"
  end

end
