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

ActiveRecord::Schema.define(version: 20141122152509) do

  create_table "client_applications", force: true do |t|
    t.string   "api_id"
    t.string   "hostname"
    t.datetime "info_updated_at"
    t.integer  "approval_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "operating_system_id"
    t.string   "api_secret_hash",     limit: 32
  end

  add_index "client_applications", ["api_id"], name: "index_client_applications_on_api_id", using: :btree
  add_index "client_applications", ["operating_system_id"], name: "index_client_applications_on_operating_system_id", using: :btree

  create_table "operating_systems", force: true do |t|
    t.string   "display_name"
    t.string   "cpe_name"
    t.string   "cpu_architecture"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
