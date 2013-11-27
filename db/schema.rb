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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131127134301) do

  create_table "book_categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "books", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "category_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "exercise_options", :force => true do |t|
    t.string   "name"
    t.integer  "exercise_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "exercise_texts", :force => true do |t|
    t.text     "content"
    t.integer  "book_id"
    t.string   "section"
    t.integer  "page"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
  end

  create_table "exercises", :force => true do |t|
    t.string   "title"
    t.string   "note"
    t.string   "answer"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "category_id"
    t.integer  "book_id"
    t.integer  "qtype_id"
    t.integer  "exercise_text_id"
  end

  create_table "exercises_homeworks", :id => false, :force => true do |t|
    t.integer "exercise_id"
    t.integer "homework_id"
  end

  create_table "grade_students", :force => true do |t|
    t.integer  "grade_num"
    t.integer  "class_num"
    t.integer  "student_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "is_accept",  :default => false
  end

  add_index "grade_students", ["class_num"], :name => "index_grade_students_on_class_num"
  add_index "grade_students", ["grade_num"], :name => "index_grade_students_on_grade_num"
  add_index "grade_students", ["student_id"], :name => "index_grade_students_on_student_id"

  create_table "grades_courses", :force => true do |t|
    t.integer  "grade_num"
    t.integer  "class_num"
    t.integer  "course_id"
    t.boolean  "is_open"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "lesson_num"
    t.integer  "teacher_id"
    t.text     "outline"
  end

  add_index "grades_courses", ["class_num"], :name => "index_grades_courses_on_class_num"
  add_index "grades_courses", ["course_id"], :name => "index_grades_courses_on_course_id"
  add_index "grades_courses", ["grade_num"], :name => "index_grades_courses_on_grade_num"

  create_table "homeworks", :force => true do |t|
    t.datetime "end_time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "enjoin"
    t.integer  "lesson_id"
    t.integer  "book_id"
    t.integer  "num"
  end

  create_table "lessons", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "grades_course_id"
    t.string   "note"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "num"
  end

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "desc"
    t.integer  "category_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "is_open",     :default => false
    t.integer  "parent_id"
    t.string   "type_name"
    t.boolean  "is_accept",   :default => false
  end

  add_index "messages", ["parent_id"], :name => "index_messages_on_parent_id"

  create_table "qtypes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.integer  "homework_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "en_name"
  end

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "settings", :force => true do |t|
    t.string   "var",                      :null => false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", :limit => 30
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "settings", ["thing_type", "thing_id", "var"], :name => "index_settings_on_thing_type_and_thing_id_and_var", :unique => true

  create_table "stu_grade_courses", :force => true do |t|
    t.string   "score"
    t.string   "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "student_courses", :force => true do |t|
    t.integer  "grades_course_id"
    t.integer  "student_id"
    t.string   "note"
    t.string   "score"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "student_courses", ["grades_course_id"], :name => "index_student_courses_on_grades_course_id"
  add_index "student_courses", ["student_id"], :name => "index_student_courses_on_student_id"

  create_table "student_homeworks", :force => true do |t|
    t.integer  "student_id"
    t.integer  "homework_id"
    t.string   "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "score"
    t.string   "level"
    t.string   "ask_note"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "login"
    t.string   "gender"
    t.string   "phone"
    t.string   "auth_code"
    t.integer  "school_id"
    t.integer  "role_id"
    t.string   "real_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
