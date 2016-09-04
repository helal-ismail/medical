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

ActiveRecord::Schema.define(version: 20160820092632) do

  create_table "appointments", force: :cascade do |t|
    t.string   "uid",              limit: 255
    t.float    "discount",         limit: 24
    t.float    "price",            limit: 24
    t.date     "appointment_date"
    t.time     "appointment_time"
    t.integer  "counter",          limit: 4
    t.integer  "state",            limit: 4
    t.text     "notes",            limit: 65535
    t.integer  "doctor_price_id",  limit: 4
    t.integer  "patient_id",       limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "clinics", force: :cascade do |t|
    t.string   "uid",               limit: 255
    t.string   "name",              limit: 255
    t.integer  "hospital_id",       limit: 4
    t.integer  "specialization_id", limit: 4
    t.text     "address",           limit: 65535
    t.string   "latitude",          limit: 255
    t.string   "longitude",         limit: 255
    t.string   "phone",             limit: 255
    t.string   "website",           limit: 255
    t.string   "email",             limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "corp_clients", force: :cascade do |t|
    t.string   "uid",        limit: 255
    t.string   "name",       limit: 255
    t.text     "address",    limit: 65535
    t.string   "field",      limit: 255
    t.string   "phone",      limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "daily_schedules", force: :cascade do |t|
    t.integer  "day_of_week",     limit: 4
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "doctor_price_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "doctor_prices", force: :cascade do |t|
    t.integer  "doctor_id",  limit: 4
    t.integer  "clinic_id",  limit: 4
    t.float    "price",      limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "hospitals", force: :cascade do |t|
    t.string   "uid",        limit: 255
    t.string   "name",       limit: 255
    t.text     "address",    limit: 65535
    t.string   "latitude",   limit: 255
    t.string   "longitude",  limit: 255
    t.string   "phone",      limit: 255
    t.string   "website",    limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "qualifications", force: :cascade do |t|
    t.integer  "degree",            limit: 4
    t.integer  "title",             limit: 4
    t.integer  "specialization_id", limit: 4
    t.date     "graduation_year"
    t.text     "description",       limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "specializations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid",                limit: 255
    t.string   "name",               limit: 255
    t.string   "email",              limit: 255
    t.string   "username",           limit: 255
    t.string   "phone",              limit: 255
    t.string   "salt",               limit: 255
    t.string   "encrypted_password", limit: 255
    t.string   "access_token",       limit: 255
    t.string   "channel",            limit: 255
    t.integer  "gender",             limit: 4
    t.text     "address",            limit: 65535
    t.string   "type",               limit: 255
    t.date     "date_of_birth"
    t.integer  "qualification_id",   limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

end
