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

ActiveRecord::Schema.define(version: 20151214200336) do

  create_table "departments", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.boolean  "gender",        limit: 1
    t.date     "birth_date"
    t.integer  "department_id", limit: 4
    t.decimal  "salary",                    precision: 10
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "employees", ["department_id"], name: "index_employees_on_department_id", using: :btree

  create_table "employees_skills", id: false, force: :cascade do |t|
    t.integer "employee_id", limit: 4
    t.integer "skill_id",    limit: 4
  end

  add_index "employees_skills", ["employee_id", "skill_id"], name: "index_employees_skills_on_employee_id_and_skill_id", using: :btree

  create_table "skills", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
