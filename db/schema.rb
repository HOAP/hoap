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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110515034215) do

  create_table "answers", :force => true do |t|
    t.integer  "participant_id"
    t.integer  "question_id"
    t.integer  "page"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", :force => true do |t|
    t.string   "key",        :limit => 12,                                                  :null => false
    t.string   "name"
    t.integer  "page",                                                   :default => 1
    t.boolean  "completed",                                              :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "c_audit"
    t.decimal  "c_bac",                    :precision => 3, :scale => 2
    t.string   "c_money"
    t.integer  "c_ldq"
    t.decimal  "c_dpw",                    :precision => 5, :scale => 2
  end

  add_index "participants", ["key"], :name => "index_participants_on_key", :unique => true

  create_table "questions", :force => true do |t|
    t.integer  "page"
    t.text     "text"
    t.text     "values"
    t.string   "atype",      :limit => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
