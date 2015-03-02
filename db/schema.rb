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

ActiveRecord::Schema.define(version: 20150302013656) do

  create_table "course_subject_relationships", force: true do |t|
    t.integer  "course_id"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_subject_relationships", ["course_id"], name: "index_course_subject_relationships_on_course_id", using: :btree
  add_index "course_subject_relationships", ["subject_id"], name: "index_course_subject_relationships_on_subject_id", using: :btree

  create_table "courses", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subject_progresses", force: true do |t|
    t.integer  "training_progress_id"
    t.integer  "course_subject_relationship_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subject_progresses", ["course_subject_relationship_id"], name: "index_subject_progresses_on_course_subject_relationship_id", using: :btree
  add_index "subject_progresses", ["training_progress_id"], name: "index_subject_progresses_on_training_progress_id", using: :btree

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_progresses", force: true do |t|
    t.integer  "subject_progress_id"
    t.integer  "task_id"
    t.date     "date_of_start"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "task_progresses", ["subject_progress_id"], name: "index_task_progresses_on_subject_progress_id", using: :btree
  add_index "task_progresses", ["task_id"], name: "index_task_progresses_on_task_id", using: :btree

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "content"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "training_progresses", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.date     "date_of_start"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "training_progresses", ["course_id"], name: "index_training_progresses_on_course_id", using: :btree
  add_index "training_progresses", ["user_id"], name: "index_training_progresses_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.boolean  "is_supervisor",   default: false
    t.string   "avatar"
    t.string   "address"
    t.date     "date_of_join"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_digest"
  end

end
