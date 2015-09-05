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

ActiveRecord::Schema.define(version: 20150904140648) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content"
    t.integer  "answerable_id"
    t.string   "answerable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

  create_table "batches", force: :cascade do |t|
    t.integer  "slug"
    t.integer  "city_id"
    t.date     "starts_at"
    t.date     "ends_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "onboarding", default: false, null: false
  end

  add_index "batches", ["city_id"], name: "index_batches_on_city_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities_users", id: false, force: :cascade do |t|
    t.integer "city_id"
    t.integer "user_id"
  end

  add_index "cities_users", ["city_id"], name: "index_cities_users_on_city_id", using: :btree
  add_index "cities_users", ["user_id"], name: "index_cities_users_on_user_id", using: :btree

  create_table "jobs", force: :cascade do |t|
    t.string   "company"
    t.string   "title"
    t.string   "ad_url"
    t.string   "contact_email"
    t.string   "city"
    t.boolean  "remote"
    t.string   "contract"
    t.text     "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
  end

  add_index "jobs", ["user_id"], name: "index_jobs_on_user_id", using: :btree

  create_table "milestones", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "milestones", ["project_id"], name: "index_milestones_on_project_id", using: :btree
  add_index "milestones", ["user_id"], name: "index_milestones_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "batch_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "tagline"
    t.string   "cover_picture_file_name"
    t.string   "cover_picture_content_type"
    t.integer  "cover_picture_file_size"
    t.datetime "cover_picture_updated_at"
  end

  add_index "projects", ["batch_id"], name: "index_projects_on_batch_id", using: :btree

  create_table "projects_users", id: false, force: :cascade do |t|
    t.integer "user_id",    null: false
    t.integer "project_id", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id", using: :btree

  create_table "resources", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "tagline"
    t.string   "screenshot_url"
  end

  add_index "resources", ["user_id"], name: "index_resources_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "uid"
    t.string   "github_nickname"
    t.string   "gravatar_url"
    t.string   "github_token"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "alumni",                 default: false, null: false
    t.boolean  "admin",                  default: false, null: false
    t.boolean  "teacher_assistant",      default: false, null: false
    t.boolean  "teacher",                default: false, null: false
    t.integer  "batch_id"
    t.string   "slack_uid"
    t.string   "phone"
    t.string   "slack_token"
    t.date     "birth_day"
    t.string   "school"
    t.boolean  "staff",                  default: false, null: false
  end

  add_index "users", ["batch_id"], name: "index_users_on_batch_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

  add_foreign_key "answers", "users"
  add_foreign_key "batches", "cities"
  add_foreign_key "jobs", "users"
  add_foreign_key "milestones", "projects"
  add_foreign_key "milestones", "users"
  add_foreign_key "projects", "batches"
  add_foreign_key "questions", "users"
  add_foreign_key "resources", "users"
  add_foreign_key "users", "batches"
end
