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

ActiveRecord::Schema.define(:version => 20110103034742) do

  create_table "assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "work_load_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "effort"
  end

  add_index "assignments", ["user_id"], :name => "index_assignments_on_user_id"
  add_index "assignments", ["work_load_id"], :name => "index_assignments_on_work_load_id"

  create_table "contract_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contracts", :force => true do |t|
    t.string   "alias"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.integer  "contract_type_id"
  end

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "microposts", ["user_id"], :name => "index_microposts_on_user_id"

  create_table "obligations", :force => true do |t|
    t.integer  "contract_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "work_load_id"
    t.decimal  "effort"
  end

  add_index "obligations", ["contract_id"], :name => "index_obligations_on_contract_id"
  add_index "obligations", ["work_load_id"], :name => "index_obligations_on_work_load_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
    t.string   "alias"
    t.boolean  "manager",            :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  create_table "work_histories", :force => true do |t|
    t.integer  "work_load_id"
    t.decimal  "effort"
    t.date     "occurrence_date"
    t.integer  "user_id"
    t.string   "work_load_name"
    t.string   "contract_name"
    t.integer  "priority"
    t.string   "work_load_type_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "contract_ids"
  end

  create_table "work_load_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "work_loads", :force => true do |t|
    t.string   "name"
    t.string   "alias"
    t.string   "description"
    t.integer  "probability"
    t.integer  "impact"
    t.integer  "priority"
    t.string   "status"
    t.integer  "percent_complete"
    t.decimal  "resolution_effort"
    t.integer  "work_load_type_id"
    t.date     "requested_date"
    t.date     "expected_date"
    t.date     "completed_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "estimate"
  end

  add_index "work_loads", ["alias"], :name => "index_work_loads_on_alias"
  add_index "work_loads", ["completed_date"], :name => "index_work_loads_on_completed_date"
  add_index "work_loads", ["name"], :name => "index_work_loads_on_name"
  add_index "work_loads", ["work_load_type_id"], :name => "index_work_loads_on_workload_type_id"

end
