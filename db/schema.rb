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

ActiveRecord::Schema.define(version: 20170526192455) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amounts", force: :cascade do |t|
    t.integer  "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "appointments", force: :cascade do |t|
    t.string   "title",       limit: 50
    t.text     "description"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "vendor_id"
    t.integer  "service_id"
    t.integer  "amount_id"
    t.boolean  "active",                 default: true, null: false
    t.integer  "duration_id"
  end

  add_index "appointments", ["duration_id"], name: "index_appointments_on_duration_id", using: :btree

  create_table "blogcomments", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "blogpost_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "blogcomments", ["blogpost_id"], name: "index_blogcomments_on_blogpost_id", using: :btree
  add_index "blogcomments", ["user_id"], name: "index_blogcomments_on_user_id", using: :btree

  create_table "blogposts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "blogposts", ["user_id"], name: "index_blogposts_on_user_id", using: :btree

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "appointment_id"
    t.string   "conf_temp"
    t.string   "email"
    t.string   "card_token"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "code_string",                                        null: false
    t.integer  "min_price",                           default: 0
    t.integer  "max_price",                           default: 1000
    t.integer  "min_value",                           default: 0
    t.integer  "max_value",                           default: 100
    t.decimal  "disc_pct",    precision: 3, scale: 2, default: 0.0
    t.integer  "disc_cost",                           default: 0
    t.date     "exp_date",                                           null: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  create_table "durations", force: :cascade do |t|
    t.string   "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "features", force: :cascade do |t|
    t.string   "title"
    t.integer  "vendor_type_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "features", ["vendor_type_id"], name: "index_features_on_vendor_type_id", using: :btree

  create_table "genders", force: :cascade do |t|
    t.string   "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "add_1"
    t.string   "add_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "total_credits", default: 1000
    t.integer  "used_credits"
    t.string   "email"
    t.string   "card_token"
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "vendor_id"
  end

  create_table "services", force: :cascade do |t|
    t.string   "title"
    t.text     "desctiption"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "vendor_type_id"
  end

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
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "username"
    t.text     "bio"
    t.integer  "gender_id",              default: 3
    t.boolean  "admin",                  default: false
    t.text     "stripe_customer"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vendor_documents", force: :cascade do |t|
    t.string   "name"
    t.integer  "vendor_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  add_index "vendor_documents", ["vendor_id"], name: "index_vendor_documents_on_vendor_id", using: :btree

  create_table "vendor_features", force: :cascade do |t|
    t.integer  "vendor_id"
    t.integer  "feature_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "vendor_features", ["feature_id"], name: "index_vendor_features_on_feature_id", using: :btree
  add_index "vendor_features", ["vendor_id"], name: "index_vendor_features_on_vendor_id", using: :btree

  create_table "vendor_licenses", force: :cascade do |t|
    t.string   "licenser"
    t.string   "name"
    t.string   "issue_date"
    t.string   "license_number"
    t.integer  "vendor_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "vendor_licenses", ["vendor_id"], name: "index_vendor_licenses_on_vendor_id", using: :btree

  create_table "vendor_locations", force: :cascade do |t|
    t.integer  "vendor_id"
    t.integer  "location_id"
    t.string   "notes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "vendor_services", force: :cascade do |t|
    t.integer  "vendor_id"
    t.integer  "service_id"
    t.string   "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vendor_types", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "category"
  end

  create_table "vendors", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",                limit: 50
    t.text     "bio"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "vendor_type_id"
    t.string   "sm_facebook"
    t.string   "sm_twitter"
    t.string   "sm_instagram"
    t.string   "sm_pinterest"
    t.string   "website",             limit: 200
    t.boolean  "active",                          default: true, null: false
  end

  add_foreign_key "appointments", "durations"
  add_foreign_key "blogcomments", "blogposts"
  add_foreign_key "blogcomments", "users"
  add_foreign_key "blogposts", "users"
  add_foreign_key "features", "vendor_types"
  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
  add_foreign_key "memberships", "users"
  add_foreign_key "vendor_documents", "vendors"
  add_foreign_key "vendor_features", "features"
  add_foreign_key "vendor_features", "vendors"
  add_foreign_key "vendor_licenses", "vendors"
end
