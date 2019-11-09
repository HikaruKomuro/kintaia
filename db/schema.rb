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

ActiveRecord::Schema.define(version: 20191031075455) do

  create_table "attendances", force: :cascade do |t|
    t.date "worked_on"
    t.time "started_at"
    t.time "finished_at"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "change_date"
    t.integer "status1"
    t.integer "status3"
    t.integer "status2"
    t.float "overtime"
    t.datetime "finish_time"
    t.string "note2"
    t.string "note3"
    t.integer "tomorrow"
    t.time "first_started_at"
    t.time "first_finished_at"
    t.date "approval_date"
    t.integer "superior"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "bases", force: :cascade do |t|
    t.string "base_name"
    t.integer "base_number"
    t.string "work_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logs", force: :cascade do |t|
    t.integer "user_id"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "request_date"
    t.integer "change_date"
    t.integer "status"
    t.integer "category"
    t.integer "applicant"
    t.string "note"
    t.datetime "finish_time"
    t.time "started_at"
    t.time "finished_at"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "department"
    t.datetime "basic_time", default: "2019-11-08 23:00:00"
    t.datetime "work_time", default: "2019-11-08 22:30:00"
    t.string "affiliation"
    t.integer "employee_number"
    t.string "uid"
    t.time "designated_work_start_time", default: "2000-01-01 00:00:00"
    t.time "designated_work_end_time", default: "2000-01-01 08:00:00"
    t.integer "superior", default: 1
    t.integer "application"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
