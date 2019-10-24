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

ActiveRecord::Schema.define(version: 20191021162110) do

  create_table "attendances", force: :cascade do |t|
    t.date "worked_on"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string "note"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "apply"
    t.integer "status1"
    t.integer "status3"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "bases", force: :cascade do |t|
    t.string "base_name"      #拠点名
    t.integer "base_number"   #拠点番号
    t.string "work_type"      #勤務状況？
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "request_date"   #申請の対象日時
    t.boolean "confirmation"    #「変更」のチェック有無
    t.integer "status"          #未申請：０、申請中：１、承認：２、否認：３
    t.integer "category"        #一ヶ月の勤怠申請：１、勤怠変更申請：２、残業申請：３
    t.integer "applicant"       #申請者のユーザーID
    t.string "note"             #備考、業務処理内容
    t.datetime "finish_time"    #終了予定時刻
    t.integer "change_date"     #「翌日」のチェック有無
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"       #ユーザー名
    t.string "email"      #メールアドレス
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"    #パスワード
    t.string "remember_digest"    #クッキー
    t.boolean "admin", default: false
    t.string "department"         #所属
    t.datetime "basic_time", default: "2019-10-23 23:00:00"    #基本勤務時間
    t.datetime "work_time", default: "2019-10-23 22:30:00"    
    t.string "affiliation"
    t.integer "employee_number"   #社員番号
    t.string "uid"                #カード番号
    t.time "designated_work_start_time", default: "2000-01-01 00:00:00"   #指定勤務開始時間
    t.time "designated_work_end_time", default: "2000-01-01 01:00:00"     #指定勤務終了時間
    t.integer "superior"        #階級
    t.integer "application"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
