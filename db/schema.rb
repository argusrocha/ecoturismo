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

ActiveRecord::Schema.define(version: 20150328032130) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "transactions", force: true do |t|
    t.integer  "user_id"
    t.string   "description"
    t.integer  "type",                           null: false
    t.boolean  "compensated",    default: false
    t.datetime "compensated_at"
    t.integer  "value_cents",    default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "trip_id"
  end

  add_index "transactions", ["trip_id"], name: "index_transactions_on_trip_id", using: :btree
  add_index "transactions", ["type"], name: "index_transactions_on_type", using: :btree
  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id", using: :btree

  create_table "trips", force: true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "value_cents", default: 0, null: false
  end

  create_table "user_data", force: true do |t|
    t.string   "name"
    t.string   "cpf"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "gender",     default: 0
    t.string   "rg"
  end

  add_index "user_data", ["cpf"], name: "index_user_data_on_cpf", unique: true, using: :btree
  add_index "user_data", ["user_id"], name: "index_user_data_on_user_id", using: :btree

  create_table "user_trips", force: true do |t|
    t.integer  "user_id"
    t.integer  "trip_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_trips", ["trip_id"], name: "index_user_trips_on_trip_id", using: :btree
  add_index "user_trips", ["user_id"], name: "index_user_trips_on_user_id", using: :btree

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.integer  "role",                   default: 0
    t.integer  "balance_cents",          default: 0,  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
