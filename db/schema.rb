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

ActiveRecord::Schema.define(version: 20130525145708) do

  create_table "countdown_users", force: true do |t|
    t.string   "cookie_identifier"
    t.string   "time"
    t.string   "email"
    t.string   "timer_title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_scheduled_emails", force: true do |t|
    t.integer  "countdown_user_id"
    t.string   "email_address"
    t.datetime "scheduled_send_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_scheduled_emails", ["countdown_user_id"], name: "index_user_scheduled_emails_on_countdown_user_id"

end
