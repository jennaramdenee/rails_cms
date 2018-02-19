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

ActiveRecord::Schema.define(version: 20180219132135) do

  create_table "articles", force: :cascade do |t|
    t.string "title", null: false
    t.string "summary"
    t.text "body", limit: 50000
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "articles_collections", id: false, force: :cascade do |t|
    t.integer "article_id", null: false
    t.integer "collection_id", null: false
    t.index ["article_id", "collection_id"], name: "index_articles_collections_on_article_id_and_collection_id"
    t.index ["collection_id", "article_id"], name: "index_articles_collections_on_collection_id_and_article_id"
  end

  create_table "collections", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
