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

ActiveRecord::Schema.define(version: 9) do

# Could not dump table "accounts" because of following NoMethodError
#   undefined method `virtual?' for #<ActiveRecord::ConnectionAdapters::Mysql2Adapter::Column:0x007f1e41091ee0>

# Could not dump table "article_tags" because of following NoMethodError
#   undefined method `virtual?' for #<ActiveRecord::ConnectionAdapters::Mysql2Adapter::Column:0x007f1e410b1cb8>

# Could not dump table "articles" because of following NoMethodError
#   undefined method `virtual?' for #<ActiveRecord::ConnectionAdapters::Mysql2Adapter::Column:0x007f1e410f3f78>

# Could not dump table "project_reports" because of following NoMethodError
#   undefined method `virtual?' for #<ActiveRecord::ConnectionAdapters::Mysql2Adapter::Column:0x007f1e4110b920>

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
end
