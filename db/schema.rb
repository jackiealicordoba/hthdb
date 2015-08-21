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

ActiveRecord::Schema.define(version: 20150820183435) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string   "company_name"
    t.text     "company_about"
    t.string   "company_website"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "hth_grads", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "email"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "hth_grads_job_listings", id: false, force: :cascade do |t|
    t.integer "job_listing_id", null: false
    t.integer "hth_grad_id",    null: false
  end

  create_table "job_listings", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "recruiter_id"
    t.string   "job_title"
    t.string   "job_location"
    t.string   "job_skills"
    t.date     "job_deadline"
    t.text     "job_description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "recruiters", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "recruiter_name"
    t.string   "recruiter_email"
    t.string   "recruiter_phone"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
