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

ActiveRecord::Schema.define(version: 2022_04_16_212902) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acquisitions", force: :cascade do |t|
    t.string "item", null: false
    t.string "quantity", null: false
    t.float "value", null: false
    t.string "manager", null: false
    t.date "acquisition_date", null: false
    t.string "contract_number"
    t.string "company", null: false
    t.string "interested_party", null: false
    t.integer "modality", null: false
    t.integer "source", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "areas", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ativos", force: :cascade do |t|
    t.string "type", null: false
    t.string "brand", null: false
    t.string "model", null: false
    t.string "serial", null: false
    t.string "tombo", null: false
    t.text "specification"
    t.bigint "acquisition_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.integer "type_count"
    t.index ["acquisition_id"], name: "index_ativos_on_acquisition_id"
  end

  create_table "attach_ativos", force: :cascade do |t|
    t.bigint "bond_id", null: false
    t.bigint "ativo_id", null: false
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "status"
    t.index ["ativo_id"], name: "index_attach_ativos_on_ativo_id"
    t.index ["bond_id"], name: "index_attach_ativos_on_bond_id"
  end

  create_table "bonds", force: :cascade do |t|
    t.bigint "subarea_id", null: false
    t.bigint "user_id", null: false
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "area", null: false
    t.index ["subarea_id"], name: "index_bonds_on_subarea_id"
    t.index ["user_id"], name: "index_bonds_on_user_id"
  end

  create_table "subareas", force: :cascade do |t|
    t.bigint "area_id"
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_subareas_on_area_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "has_many_bond"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "ativos", "acquisitions"
  add_foreign_key "attach_ativos", "ativos"
  add_foreign_key "attach_ativos", "bonds"
  add_foreign_key "bonds", "subareas"
  add_foreign_key "bonds", "users"
  add_foreign_key "subareas", "areas"
end
