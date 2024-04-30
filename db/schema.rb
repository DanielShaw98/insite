# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_30_154210) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "avatars", force: :cascade do |t|
    t.string "image_url"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_avatars_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "creators", force: :cascade do |t|
    t.text "bio"
    t.string "specialisation"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_creators_on_user_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable"
  end

  create_table "pledges", force: :cascade do |t|
    t.text "content"
    t.integer "votes"
    t.bigint "user_id", null: false
    t.bigint "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_pledges_on_creator_id"
    t.index ["user_id"], name: "index_pledges_on_user_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "purchase_cost"
    t.string "purchase_status"
    t.string "payment_details"
    t.bigint "user_id", null: false
    t.bigint "video_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_purchases_on_user_id"
    t.index ["video_id"], name: "index_purchases_on_video_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "content"
    t.integer "rating"
    t.bigint "user_id", null: false
    t.bigint "video_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reviews_on_user_id"
    t.index ["video_id"], name: "index_reviews_on_video_id"
  end

  create_table "socials", force: :cascade do |t|
    t.string "platform"
    t.string "link"
    t.string "icon_path"
    t.bigint "user_id", null: false
    t.bigint "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_socials_on_creator_id"
    t.index ["user_id"], name: "index_socials_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "subscription_cost"
    t.string "subscription_status"
    t.string "payment_details"
    t.date "start_date"
    t.date "end_date"
    t.bigint "user_id", null: false
    t.bigint "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_subscriptions_on_creator_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "requirements"
    t.text "learning"
    t.text "audience"
    t.text "includes"
    t.string "external_video_url"
    t.string "accessibility"
    t.integer "views"
    t.float "average_rating"
    t.string "thumbnail_url"
    t.bigint "creator_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_videos_on_category_id"
    t.index ["creator_id"], name: "index_videos_on_creator_id"
  end

  add_foreign_key "avatars", "users"
  add_foreign_key "creators", "users"
  add_foreign_key "pledges", "creators"
  add_foreign_key "pledges", "users"
  add_foreign_key "purchases", "users"
  add_foreign_key "purchases", "videos"
  add_foreign_key "reviews", "users"
  add_foreign_key "reviews", "videos"
  add_foreign_key "socials", "creators"
  add_foreign_key "socials", "users"
  add_foreign_key "subscriptions", "creators"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "videos", "categories"
  add_foreign_key "videos", "creators"
end
