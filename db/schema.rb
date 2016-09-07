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


ActiveRecord::Schema.define(version: 20160905110400) do


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

  create_table "attachinary_files", force: :cascade do |t|
    t.integer  "attachinariable_id"
    t.string   "attachinariable_type"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachinary_files", ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree

  create_table "batches", force: :cascade do |t|
    t.string   "slug"
    t.integer  "city_id"
    t.date     "starts_at"
    t.date     "ends_at"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "onboarding",               default: false,   null: false
    t.string   "slack_id"
    t.string   "youtube_id"
    t.boolean  "live",                     default: false,   null: false
    t.string   "meta_image_file_name"
    t.string   "meta_image_content_type"
    t.integer  "meta_image_file_size"
    t.datetime "meta_image_updated_at"
    t.boolean  "last_seats",               default: false,   null: false
    t.boolean  "full",                     default: false,   null: false
    t.string   "time_zone",                default: "Paris"
    t.boolean  "open_for_registration",    default: false,   null: false
    t.string   "trello_inbox_list_id"
    t.integer  "price_cents",              default: 0,       null: false
    t.string   "price_currency",           default: "EUR",   null: false
    t.string   "cover_image_file_name"
    t.string   "cover_image_content_type"
    t.integer  "cover_image_file_size"
    t.datetime "cover_image_updated_at"
    t.boolean  "waiting_list",             default: false,   null: false
  end

  add_index "batches", ["city_id"], name: "index_batches_on_city_id", using: :btree

  create_table "batches_users", id: false, force: :cascade do |t|
    t.integer "batch_id"
    t.integer "user_id"
  end

  add_index "batches_users", ["batch_id"], name: "index_batches_users_on_batch_id", using: :btree
  add_index "batches_users", ["user_id"], name: "index_batches_users_on_user_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "location"
    t.string   "address"
    t.text     "description_fr"
    t.text     "description_en"
    t.integer  "meetup_id"
    t.string   "twitter_url"
    t.string   "city_picture_file_name"
    t.string   "city_picture_content_type"
    t.integer  "city_picture_file_size"
    t.datetime "city_picture_updated_at"
    t.string   "location_picture_file_name"
    t.string   "location_picture_content_type"
    t.integer  "location_picture_file_size"
    t.datetime "location_picture_updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "slug"
    t.string   "classroom_picture_file_name"
    t.string   "classroom_picture_content_type"
    t.integer  "classroom_picture_file_size"
    t.datetime "classroom_picture_updated_at"
    t.string   "course_locale"
    t.text     "logistic_specifics"
    t.string   "company_name"
    t.string   "company_nature"
    t.string   "company_hq"
    t.string   "company_purpose_and_registration"
    t.string   "training_address"
    t.string   "apply_facebook_pixel"
    t.string   "mailchimp_list_id"
    t.string   "mailchimp_api_key"
    t.string   "slack_channel_id"
    t.text     "marketing_specifics"
    t.string   "contact_phone_number"
    t.boolean  "contact_phone_number_displayed",   default: false, null: false
    t.string   "contact_phone_number_name"
    t.integer  "city_group_id"
  end

  add_index "cities", ["city_group_id"], name: "index_cities_on_city_group_id", using: :btree
  add_index "cities", ["slug"], name: "index_cities_on_slug", unique: true, using: :btree

  create_table "cities_users", id: false, force: :cascade do |t|
    t.integer "city_id"
    t.integer "user_id"
  end

  add_index "cities_users", ["city_id"], name: "index_cities_users_on_city_id", using: :btree
  add_index "cities_users", ["user_id"], name: "index_cities_users_on_user_id", using: :btree

  create_table "city_groups", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "url"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

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

  create_table "ordered_lists", force: :cascade do |t|
    t.string   "name"
    t.string   "element_type"
    t.text     "slugs",        default: [],              array: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "positions", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "positions", ["company_id"], name: "index_positions_on_company_id", using: :btree
  add_index "positions", ["user_id"], name: "index_positions_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "batch_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "tagline_en"
    t.string   "cover_picture_file_name"
    t.string   "cover_picture_content_type"
    t.integer  "cover_picture_file_size"
    t.datetime "cover_picture_updated_at"
    t.integer  "position"
    t.string   "slug"
    t.string   "tagline_fr"
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
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "solved",     default: false, null: false
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

  create_table "stories", force: :cascade do |t|
    t.text     "description_en"
    t.text     "description_fr"
    t.boolean  "published",            default: false, null: false
    t.integer  "user_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "company_id"
    t.string   "title_en"
    t.string   "title_fr"
    t.text     "summary_fr"
    t.text     "summary_en"
    t.string   "slug"
  end

  add_index "stories", ["company_id"], name: "index_stories_on_company_id", using: :btree
  add_index "stories", ["slug"], name: "index_stories_on_slug", unique: true, using: :btree
  add_index "stories", ["user_id"], name: "index_stories_on_user_id", using: :btree

  create_table "testimonials", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "content"
    t.string   "locale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "testimonials", ["user_id"], name: "index_testimonials_on_user_id", using: :btree

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
    t.text     "bio_en"
    t.text     "bio_fr"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "role"
    t.string   "twitter_nickname"
    t.boolean  "noindex",                default: false, null: false
    t.text     "private_bio"
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
  add_foreign_key "cities", "city_groups"
  add_foreign_key "jobs", "users"
  add_foreign_key "milestones", "projects"
  add_foreign_key "milestones", "users"
  add_foreign_key "positions", "companies"
  add_foreign_key "positions", "users"
  add_foreign_key "projects", "batches"
  add_foreign_key "questions", "users"
  add_foreign_key "resources", "users"
  add_foreign_key "stories", "companies"
  add_foreign_key "stories", "users"
  add_foreign_key "testimonials", "users"
  add_foreign_key "users", "batches"
end
