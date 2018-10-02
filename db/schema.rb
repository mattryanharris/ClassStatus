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

ActiveRecord::Schema.define(version: 20140218061818) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "class_sessions", force: true do |t|
    t.string   "name"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "days"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
    t.string   "class_code"
  end

  create_table "class_sessions_subscribers", id: false, force: true do |t|
    t.integer "class_session_id"
    t.integer "subscriber_id"
  end

  add_index "class_sessions_subscribers", ["class_session_id"], name: "index_class_sessions_subscribers_on_class_session_id", using: :btree
  add_index "class_sessions_subscribers", ["subscriber_id"], name: "index_class_sessions_subscribers_on_subscriber_id", using: :btree

  create_table "class_sessions_users", id: false, force: true do |t|
    t.integer "class_session_id"
    t.integer "user_id"
  end

  add_index "class_sessions_users", ["class_session_id"], name: "index_class_sessions_users_on_class_session_id", using: :btree
  add_index "class_sessions_users", ["user_id"], name: "index_class_sessions_users_on_user_id", using: :btree

  create_table "notifications", force: true do |t|
    t.string   "type"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "extra_data"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "sms_number"
    t.string   "sms_carrier"
    t.string   "roles",                                            array: true
    t.string   "stripe_customer_token"
    t.string   "title"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "plan"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
