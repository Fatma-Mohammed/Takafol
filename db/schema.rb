# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_16_084510) do

  create_table "active_admin_comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "cases", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "job"
    t.text "description"
    t.integer "children_num"
    t.string "marital_status"
    t.string "email"
    t.integer "priority"
    t.string "phone"
    t.string "address"
    t.string "national_id", null: false
    t.string "NID_img"
    t.decimal "amount_needed", precision: 10, default: "500"
    t.decimal "amount_obtained", precision: 10, default: "0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "city_id", null: false
    t.index ["city_id"], name: "index_cases_on_city_id"
  end

  create_table "charities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.text "address"
    t.string "phone_number"
    t.text "description"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "city_id", null: false
    t.index ["city_id"], name: "index_charities_on_city_id"
    t.index ["email"], name: "index_charities_on_email", unique: true
    t.index ["reset_password_token"], name: "index_charities_on_reset_password_token", unique: true
  end

  create_table "charities_cases", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "charity_id", null: false
    t.bigint "case_id", null: false
    t.index ["case_id"], name: "index_charities_cases_on_case_id"
    t.index ["charity_id"], name: "index_charities_cases_on_charity_id"
  end

  create_table "cities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "name_en"
    t.bigint "governorate_id", null: false
    t.index ["governorate_id"], name: "index_cities_on_governorate_id"
  end

  create_table "donors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.string "national_id", null: false
    t.string "national_id_img"
    t.text "address"
    t.text "phone"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_donors_on_email", unique: true
    t.index ["reset_password_token"], name: "index_donors_on_reset_password_token", unique: true
  end

  create_table "donors_cases", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "donor_id", null: false
    t.bigint "case_id", null: false
    t.index ["case_id"], name: "index_donors_cases_on_case_id"
    t.index ["donor_id"], name: "index_donors_cases_on_donor_id"
  end

  create_table "governorates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "name_en"
  end

  add_foreign_key "cases", "cities"
  add_foreign_key "charities", "cities"
  add_foreign_key "charities_cases", "cases", on_delete: :cascade
  add_foreign_key "charities_cases", "charities", on_delete: :cascade
  add_foreign_key "cities", "governorates", on_delete: :cascade
  add_foreign_key "donors_cases", "cases", on_delete: :cascade
  add_foreign_key "donors_cases", "donors", on_delete: :cascade
end
