# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091112113101) do

  create_table "assignment_types", :force => true do |t|
    t.string "name"
    t.string "short_code"
  end

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "code"
    t.boolean  "is_active",   :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_assignments", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "assignment_type_id"
    t.float    "hourly_rate"
    t.date     "date_start"
    t.date     "date_end"
    t.string   "role"
    t.boolean  "is_active",              :default => true
    t.float    "allotted_hours"
    t.float    "allotted_hours_overrun"
    t.boolean  "notify_pm",              :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_pm",                  :default => false
  end

  create_table "project_managers", :id => false, :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.integer  "customer_id"
    t.string   "name"
    t.text     "description"
    t.string   "contact"
    t.string   "project_code"
    t.boolean  "is_active",    :default => true
    t.boolean  "is_billable",  :default => true
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_default",   :default => false
  end

  create_table "timesheet_comments", :force => true do |t|
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "comment_date"
  end

  create_table "timesheet_entries", :force => true do |t|
    t.integer  "project_assignment_id"
    t.date     "entry_date"
    t.float    "hours"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "comment"
  end

  create_table "user_assignments", :force => true do |t|
    t.integer "user_role_id"
    t.integer "user_id"
  end

  create_table "user_roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "last_name"
    t.boolean  "is_active",                                :default => true
    t.integer  "department_id"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
