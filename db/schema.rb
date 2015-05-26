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

ActiveRecord::Schema.define(version: 18) do

  create_table "article_tags", id: false, force: true do |t|
    t.integer  "article_id"
    t.string   "tag"
    t.integer  "delete_flg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "article_tags", ["article_id", "tag"], name: "index_article_tags_on_article_id_and_tag", unique: true, using: :btree

  create_table "articles", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "article"
    t.integer  "delete_flg"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "likes",      default: 0
  end

  create_table "oauths", force: true do |t|
    t.integer  "user_id"
    t.integer  "provider"
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauths", ["user_id"], name: "index_oauths_on_user_id", using: :btree

  create_table "project_reports", force: true do |t|
    t.integer  "quotn_no",        limit: 8,  null: false
    t.text     "report"
    t.string   "report_psnal_cd", limit: 10, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_reports", ["quotn_no"], name: "index_project_reports_on_quotn_no", using: :btree

  create_table "tags", id: false, force: true do |t|
    t.string   "tag"
    t.integer  "delete_flg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["tag"], name: "index_tags_on_tag", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "psnal_cd"
    t.string   "icon_path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mst_blg_cd"
    t.string   "full_name"
    t.string   "report_mail"
  end

  create_table "worktimes", force: true do |t|
    t.string   "psnal_cd",                   null: false
    t.date     "date",                       null: false
    t.string   "calendar",                   null: false
    t.string   "absence",                    null: false
    t.string   "work_class",                 null: false
    t.string   "start",                      null: false
    t.string   "start_mc",                   null: false
    t.string   "end",                        null: false
    t.string   "end_mc",                     null: false
    t.string   "going_out",                  null: false
    t.string   "going_out_mc",               null: false
    t.string   "return",                     null: false
    t.float    "worked_hours",    limit: 24, null: false
    t.float    "l_worked_hours",  limit: 24, null: false
    t.float    "h_worked_hours",  limit: 24, null: false
    t.float    "hl_worked_hours", limit: 24, null: false
    t.float    "tardy_hours",     limit: 24, null: false
    t.float    "early_hours",     limit: 24, null: false
    t.float    "private_hours",   limit: 24, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "worktimes", ["date"], name: "index_worktimes_on_date", using: :btree
  add_index "worktimes", ["psnal_cd"], name: "index_worktimes_on_psnal_cd", using: :btree

end
