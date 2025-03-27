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

ActiveRecord::Schema[8.0].define(version: 2025_03_27_170613) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "deputies", force: :cascade do |t|
    t.string "external_id", null: false
    t.string "legal_name"
    t.string "cpf"
    t.string "gender"
    t.string "website_url"
    t.date "birthdate"
    t.date "death_date"
    t.string "birth_state"
    t.string "birth_city"
    t.string "education_level"
    t.string "name"
    t.bigint "party_id"
    t.string "state_acronym"
    t.string "legislature_external_id"
    t.string "photo_url"
    t.string "email"
    t.date "status_date"
    t.string "electoral_name", null: false
    t.string "status"
    t.string "electoral_status"
    t.string "status_description"
    t.json "cabinet", default: {}
    t.json "social_medias", default: []
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["electoral_name"], name: "index_deputies_on_electoral_name"
    t.index ["external_id"], name: "index_deputies_on_external_id", unique: true
    t.index ["party_id"], name: "index_deputies_on_party_id"
  end

  create_table "deputy_expenses", force: :cascade do |t|
    t.integer "year", null: false
    t.integer "month", null: false
    t.string "expense_type"
    t.bigint "document_code", null: false
    t.string "document_type"
    t.integer "document_type_code"
    t.datetime "document_date"
    t.string "document_number"
    t.decimal "document_value", precision: 10, scale: 2
    t.string "document_url"
    t.string "supplier_name"
    t.string "supplier_cnpj_cpf"
    t.decimal "net_value", precision: 10, scale: 2
    t.decimal "gloss_value", precision: 10, scale: 2
    t.string "reimbursement_number"
    t.bigint "batch_code"
    t.integer "installment"
    t.bigint "deputy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deputy_id"], name: "index_deputy_expenses_on_deputy_id"
    t.index ["document_code"], name: "index_deputy_expenses_on_document_code"
    t.index ["month"], name: "index_deputy_expenses_on_month"
    t.index ["year"], name: "index_deputy_expenses_on_year"
  end

  create_table "deputy_external_mandates", force: :cascade do |t|
    t.string "position"
    t.string "state_acronym"
    t.string "municipality"
    t.integer "start_year"
    t.integer "end_year"
    t.string "election_party_acronym"
    t.bigint "deputy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deputy_id"], name: "index_deputy_external_mandates_on_deputy_id"
    t.index ["election_party_acronym"], name: "index_deputy_external_mandates_on_election_party_acronym"
    t.index ["municipality"], name: "index_deputy_external_mandates_on_municipality"
    t.index ["state_acronym"], name: "index_deputy_external_mandates_on_state_acronym"
  end

  create_table "deputy_fronts", force: :cascade do |t|
    t.bigint "deputy_id"
    t.bigint "front_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deputy_id"], name: "index_deputy_fronts_on_deputy_id"
    t.index ["front_id"], name: "index_deputy_fronts_on_front_id"
  end

  create_table "deputy_histories", force: :cascade do |t|
    t.integer "deputy_external_id", null: false
    t.string "party_acronym"
    t.string "state_acronym"
    t.integer "legislature_id"
    t.string "photo_url"
    t.datetime "datetime"
    t.string "status"
    t.string "electoral_condition"
    t.text "status_description"
    t.bigint "deputy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deputy_external_id"], name: "index_deputy_histories_on_deputy_external_id"
    t.index ["deputy_id"], name: "index_deputy_histories_on_deputy_id"
    t.index ["party_acronym"], name: "index_deputy_histories_on_party_acronym"
    t.index ["state_acronym"], name: "index_deputy_histories_on_state_acronym"
  end

  create_table "deputy_ocupations", force: :cascade do |t|
    t.string "title"
    t.string "entity"
    t.string "entity_state"
    t.string "entity_country"
    t.integer "start_year"
    t.integer "end_year"
    t.bigint "deputy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deputy_id"], name: "index_deputy_ocupations_on_deputy_id"
    t.index ["entity"], name: "index_deputy_ocupations_on_entity"
    t.index ["entity_state"], name: "index_deputy_ocupations_on_entity_state"
    t.index ["start_year"], name: "index_deputy_ocupations_on_start_year"
    t.index ["title"], name: "index_deputy_ocupations_on_title"
  end

  create_table "deputy_speeches", force: :cascade do |t|
    t.string "start_time"
    t.string "end_time"
    t.string "event_uri"
    t.string "speech_type"
    t.string "text_url"
    t.string "audio_url"
    t.string "video_url"
    t.string "keywords"
    t.text "summary"
    t.text "transcription"
    t.json "event_phase", default: {}
    t.bigint "deputy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deputy_id"], name: "index_deputy_speeches_on_deputy_id"
    t.index ["start_time"], name: "index_deputy_speeches_on_start_time"
  end

  create_table "deputy_votes", force: :cascade do |t|
    t.bigint "deputy_id"
    t.bigint "vote_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deputy_id"], name: "index_deputy_votes_on_deputy_id"
    t.index ["vote_id"], name: "index_deputy_votes_on_vote_id"
  end

  create_table "event_deputies", force: :cascade do |t|
    t.bigint "deputy_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deputy_id"], name: "index_event_deputies_on_deputy_id"
    t.index ["event_id"], name: "index_event_deputies_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "external_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "status"
    t.string "event_type"
    t.text "description"
    t.string "external_location"
    t.json "chamber_location"
    t.string "recording_url"
    t.json "organs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_type"], name: "index_events_on_event_type"
    t.index ["external_id"], name: "index_events_on_external_id", unique: true
    t.index ["start_time"], name: "index_events_on_start_time"
  end

  create_table "fronts", force: :cascade do |t|
    t.string "external_id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "deputy_id"
    t.index ["deputy_id"], name: "index_fronts_on_deputy_id"
    t.index ["external_id"], name: "index_fronts_on_external_id", unique: true
  end

  create_table "parties", force: :cascade do |t|
    t.string "external_id"
    t.string "party_acronym"
    t.string "party_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_parties_on_external_id"
  end

  create_table "professions", force: :cascade do |t|
    t.datetime "datetime"
    t.integer "profession_type_code"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "deputy_id"
    t.index ["deputy_id"], name: "index_professions_on_deputy_id"
    t.index ["profession_type_code"], name: "index_professions_on_profession_type_code"
    t.index ["title"], name: "index_professions_on_title"
  end

  create_table "vote_orientations", force: :cascade do |t|
    t.string "vote_orientation"
    t.string "leadership_type_code"
    t.string "party_bloc_acronym", null: false
    t.integer "party_bloc_code"
    t.string "party_bloc_uri"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["leadership_type_code"], name: "index_vote_orientations_on_leadership_type_code"
    t.index ["party_bloc_acronym"], name: "index_vote_orientations_on_party_bloc_acronym"
    t.index ["vote_orientation"], name: "index_vote_orientations_on_vote_orientation"
  end

  create_table "votes", force: :cascade do |t|
    t.string "external_id", null: false
    t.date "date"
    t.datetime "registration_datetime"
    t.string "organ_acronym"
    t.integer "organ_id"
    t.integer "event_id"
    t.text "description"
    t.integer "approval_type"
    t.text "last_opening_description"
    t.datetime "last_opening_datetime"
    t.json "last_proposition"
    t.json "registered_effects", default: []
    t.json "possible_objects"
    t.json "affected_propositions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["approval_type"], name: "index_votes_on_approval_type"
    t.index ["date"], name: "index_votes_on_date"
    t.index ["event_id"], name: "index_votes_on_event_id"
    t.index ["external_id"], name: "index_votes_on_external_id", unique: true
    t.index ["organ_id"], name: "index_votes_on_organ_id"
  end

  add_foreign_key "deputy_expenses", "deputies"
  add_foreign_key "deputy_external_mandates", "deputies"
  add_foreign_key "deputy_histories", "deputies"
  add_foreign_key "deputy_ocupations", "deputies"
  add_foreign_key "deputy_speeches", "deputies"
end
