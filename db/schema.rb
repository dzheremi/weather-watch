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

ActiveRecord::Schema.define(version: 20160406013109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorites", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "station_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["station_id"], name: "index_favorites_on_station_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "metrics", force: true do |t|
    t.string   "name",         null: false
    t.string   "abbreviation", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "observations", force: true do |t|
    t.integer  "station_id",     null: false
    t.datetime "recording_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "observations", ["station_id"], name: "index_observations_on_station_id", using: :btree

  create_table "reading_types", force: true do |t|
    t.string   "name",                          null: false
    t.string   "bom_field_name",                null: false
    t.boolean  "numeric",        default: true
    t.integer  "metric_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "display_order",  default: 0
  end

  add_index "reading_types", ["metric_id"], name: "index_reading_types_on_metric_id", using: :btree

  create_table "readings", force: true do |t|
    t.integer  "observation_id",                                         null: false
    t.integer  "reading_type_id",                                        null: false
    t.decimal  "numeric_value",   precision: 10, scale: 3, default: 0.0
    t.string   "string_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "readings", ["numeric_value"], name: "index_readings_on_numeric_value", using: :btree
  add_index "readings", ["observation_id"], name: "index_readings_on_observation_id", using: :btree
  add_index "readings", ["reading_type_id"], name: "index_readings_on_reading_type_id", using: :btree

  create_table "states", force: true do |t|
    t.string   "name",          null: false
    t.string   "abbreviation",  null: false
    t.string   "product_group", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stations", force: true do |t|
    t.integer  "state_id",                                            null: false
    t.string   "name",                                                null: false
    t.decimal  "latitude",    precision: 5, scale: 2, default: 0.0
    t.decimal  "longitude",   precision: 5, scale: 2, default: 0.0
    t.integer  "timezone_id",                                         null: false
    t.string   "station_url",                                         null: false
    t.string   "json_url",                                            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "capital",                             default: false
  end

  add_index "stations", ["state_id"], name: "index_stations_on_state_id", using: :btree
  add_index "stations", ["timezone_id"], name: "index_stations_on_timezone_id", using: :btree

  create_table "timezones", force: true do |t|
    t.string   "name",         null: false
    t.string   "abbreviation", null: false
    t.string   "location",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",           null: false
    t.string   "name",               null: false
    t.string   "email",              null: false
    t.text     "encrypted_password", null: false
    t.integer  "timezone_id",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "salt",               null: false
  end

  add_index "users", ["timezone_id"], name: "index_users_on_timezone_id", using: :btree

end
