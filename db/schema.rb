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

ActiveRecord::Schema[7.0].define(version: 2023_09_04_101021) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "doctor_id", null: false
    t.datetime "appointment_date"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ordonnance_id"
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["ordonnance_id"], name: "index_appointments_on_ordonnance_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "specialty"
    t.string "accreditation_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_doctors_on_user_id"
  end

  create_table "medications", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ordo_medications", force: :cascade do |t|
    t.bigint "ordonnance_id", null: false
    t.bigint "medication_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "frequency"
    t.integer "duration"
    t.text "commentary"
    t.index ["medication_id"], name: "index_ordo_medications_on_medication_id"
    t.index ["ordonnance_id"], name: "index_ordo_medications_on_ordonnance_id"
  end

  create_table "ordonnances", force: :cascade do |t|
    t.boolean "is_signed"
    t.boolean "is_sent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "appointment_id"
    t.integer "ordonnance_number"
    t.boolean "is_used", default: false
    t.boolean "qr_generated", default: false
    t.index ["appointment_id"], name: "index_ordonnances_on_appointment_id"
  end

  create_table "patients", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_patients_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "appointments", "doctors"
  add_foreign_key "appointments", "ordonnances"
  add_foreign_key "appointments", "patients"
  add_foreign_key "doctors", "users"
  add_foreign_key "ordo_medications", "medications"
  add_foreign_key "ordo_medications", "ordonnances"
  add_foreign_key "ordonnances", "appointments"
  add_foreign_key "patients", "users"
end
