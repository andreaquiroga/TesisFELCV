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

ActiveRecord::Schema.define(version: 20141031140054) do

  create_table "cases", force: true do |t|
    t.string   "code"
    t.string   "init_date"
    t.string   "end_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cases", ["user_id"], name: "index_cases_on_user_id"

  create_table "civil_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "complaints", force: true do |t|
    t.date     "fact_date"
    t.string   "place"
    t.time     "fact_time"
    t.string   "cincunstancial_relation"
    t.string   "nature"
    t.string   "aggressor_relation"
    t.integer  "case_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sign"
    t.string   "complaint_signed_file_name"
    t.string   "complaint_signed_content_type"
    t.integer  "complaint_signed_file_size"
    t.datetime "complaint_signed_updated_at"
  end

  add_index "complaints", ["case_id"], name: "index_complaints_on_case_id"

  create_table "conclusions", force: true do |t|
    t.string   "antecedents"
    t.string   "direct_action"
    t.string   "police_actions"
    t.string   "request"
    t.integer  "case_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "conclusion_signed_file_name"
    t.string   "conclusion_signed_content_type"
    t.integer  "conclusion_signed_file_size"
    t.datetime "conclusion_signed_updated_at"
    t.boolean  "sign"
  end

  add_index "conclusions", ["case_id"], name: "index_conclusions_on_case_id"

  create_table "direct_actions", force: true do |t|
    t.string   "police_name"
    t.string   "police_station"
    t.string   "police_ci"
    t.string   "police_grade"
    t.string   "station_zone"
    t.string   "station_acronym"
    t.string   "police_phone"
    t.date     "fact_date"
    t.string   "place"
    t.time     "fact_time"
    t.string   "nature"
    t.string   "cincunstancial_relation"
    t.integer  "case_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "direct_action_signed_file_name"
    t.string   "direct_action_signed_content_type"
    t.integer  "direct_action_signed_file_size"
    t.datetime "direct_action_signed_updated_at"
    t.boolean  "sign"
  end

  add_index "direct_actions", ["case_id"], name: "index_direct_actions_on_case_id"

  create_table "genders", force: true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interviews", force: true do |t|
    t.string   "resume"
    t.boolean  "sign"
    t.integer  "case_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "interview_signed_file_name"
    t.string   "interview_signed_content_type"
    t.integer  "interview_signed_file_size"
    t.datetime "interview_signed_updated_at"
  end

  add_index "interviews", ["case_id"], name: "index_interviews_on_case_id"

  create_table "items", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "place"
    t.integer  "direct_action_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["direct_action_id"], name: "index_items_on_direct_action_id"

  create_table "links", force: true do |t|
    t.string   "role"
    t.integer  "case_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "links", ["case_id"], name: "index_links_on_case_id"
  add_index "links", ["person_id"], name: "index_links_on_person_id"

  create_table "locations", force: true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.string   "place"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.integer  "ci"
    t.string   "name"
    t.string   "paternal_last_name"
    t.string   "maternal_last_name"
    t.string   "civil_status"
    t.string   "nationality"
    t.string   "natural_of"
    t.string   "work"
    t.string   "work_phone"
    t.string   "ocupation"
    t.string   "gender"
    t.string   "phone"
    t.string   "mobile"
    t.date     "birthdate"
    t.integer  "location_home_id"
    t.integer  "location_work_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "person_roles", force: true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.string   "text"
    t.string   "answer"
    t.integer  "interview_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["interview_id"], name: "index_questions_on_interview_id"

  create_table "reports", force: true do |t|
    t.string   "name"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", force: true do |t|
    t.string   "label"
    t.decimal  "porcentage"
    t.integer  "report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "results", ["report_id"], name: "index_results_on_report_id"

  create_table "roles", force: true do |t|
    t.string "name"
  end

  create_table "stations", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_statuses", force: true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                    default: "", null: false
    t.string   "encrypted_password",       default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "station_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.integer  "ci"
    t.string   "name"
    t.string   "paternal_last_name"
    t.string   "maternal_last_name"
    t.string   "grade"
    t.string   "address"
    t.string   "phone"
    t.string   "mobile"
    t.string   "admission_date"
    t.string   "birthdate"
    t.string   "last_work"
    t.string   "status"
    t.integer  "turn"
    t.string   "upload_cert_file_name"
    t.string   "upload_cert_content_type"
    t.integer  "upload_cert_file_size"
    t.datetime "upload_cert_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["station_id"], name: "index_users_on_station_id"

end
