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

ActiveRecord::Schema.define(version: 20150123192519) do

  create_table "authorizations", force: true do |t|
    t.integer  "role_id"
    t.integer  "use_case_id"
    t.boolean  "add",         default: false
    t.boolean  "edit",        default: false
    t.boolean  "view",        default: false
    t.boolean  "remove",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authorizations", ["role_id"], name: "role_id", using: :btree
  add_index "authorizations", ["use_case_id"], name: "use_case_id", using: :btree

  create_table "cities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_classes", force: true do |t|
    t.string   "name"
    t.integer  "institution_id"
    t.integer  "course_id"
    t.string   "begin",          limit: 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "end",            limit: 10
    t.boolean  "closed",                    default: false, null: false
  end

  add_index "course_classes", ["course_id"], name: "course_id", using: :btree
  add_index "course_classes", ["institution_id"], name: "institution_id", using: :btree

  create_table "course_classes_documents", force: true do |t|
    t.integer  "document_id"
    t.integer  "course_class_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_classes_employees", force: true do |t|
    t.integer  "course_class_id"
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "acronym"
  end

  create_table "document_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: true do |t|
    t.string   "name"
    t.integer  "document_category_id"
    t.string   "path"
    t.string   "extension"
    t.string   "size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "original_file_name"
    t.string   "disc_file_name"
  end

  create_table "employee_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", force: true do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "rg"
    t.string   "cpf"
    t.string   "birthday",             limit: 10
    t.integer  "employee_category_id"
    t.integer  "city_id"
    t.string   "address"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employees", ["city_id"], name: "city_id", using: :btree
  add_index "employees", ["employee_category_id"], name: "employee_category_id", using: :btree

  create_table "event_participants", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.date     "notified_at"
    t.integer  "event_id"
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "begin"
    t.datetime "end"
    t.string   "local"
    t.text     "resume"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "institutions", force: true do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "email"
    t.string   "site"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "contact",      limit: 100
    t.string   "acronym",      limit: 20
  end

  create_table "parameters", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registration_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "show_list_of_presence", default: false
  end

  create_table "registrations", force: true do |t|
    t.integer  "student_id"
    t.integer  "course_class_id"
    t.integer  "registration_status_id"
    t.string   "date_abandonment",       limit: 10
    t.string   "date_conclusion",        limit: 10
    t.float    "end_note",               limit: 24
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "registrations", ["course_class_id"], name: "course_class_id", using: :btree
  add_index "registrations", ["student_id"], name: "student_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles_users", ["role_id"], name: "role_id", using: :btree
  add_index "roles_users", ["user_id"], name: "user_id", using: :btree

  create_table "students", force: true do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "email"
    t.boolean  "has_badge"
    t.string   "badge_observation"
    t.string   "birthday",          limit: 10
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rg"
    t.string   "cpf"
    t.string   "sanguine_type"
    t.integer  "city_id"
    t.string   "badge_number",      limit: 15
    t.string   "badge_end_date",    limit: 10
  end

  add_index "students", ["city_id"], name: "index_students_on_city_id", using: :btree

  create_table "use_cases", force: true do |t|
    t.string   "name"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "admin"
    t.boolean  "active"
    t.boolean  "super",                  default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
