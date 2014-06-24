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

ActiveRecord::Schema.define(:version => 20140621030927) do

  create_table "app_events", :force => true do |t|
    t.string   "event",      :limit => 64, :null => false
    t.string   "section",    :limit => 32, :null => false
    t.integer  "user_id",                  :null => false
    t.boolean  "successful",               :null => false
    t.datetime "created_at"
  end

  add_index "app_events", ["created_at"], :name => "index_app_events_on_created_at"
  add_index "app_events", ["user_id", "created_at"], :name => "index_app_events_on_user_id_and_created_at"

  create_table "auth_events", :force => true do |t|
    t.string   "event",      :limit => 64,                    :null => false
    t.integer  "user_id",                                     :null => false
    t.string   "remote_ip",  :limit => 16
    t.boolean  "trusted",                  :default => false, :null => false
    t.datetime "created_at"
  end

  add_index "auth_events", ["created_at"], :name => "index_auth_events_on_created_at"
  add_index "auth_events", ["user_id", "created_at"], :name => "index_auth_events_on_user_id_and_created_at"

  create_table "book_categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "grade_num"
  end

  create_table "books", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "category_id"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "change_teacher_logs", :force => true do |t|
    t.integer  "prev_teacher_id"
    t.integer  "curr_teacher_id"
    t.integer  "admin_id"
    t.integer  "grades_course_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "new_grades_course_id"
    t.integer  "message_id"
  end

  add_index "change_teacher_logs", ["admin_id"], :name => "index_change_teacher_logs_on_admin_id"
  add_index "change_teacher_logs", ["curr_teacher_id"], :name => "index_change_teacher_logs_on_curr_teacher_id"
  add_index "change_teacher_logs", ["grades_course_id"], :name => "index_change_teacher_logs_on_grades_course_id"
  add_index "change_teacher_logs", ["message_id"], :name => "index_change_teacher_logs_on_message_id"
  add_index "change_teacher_logs", ["new_grades_course_id"], :name => "index_change_teacher_logs_on_new_grades_course_id"
  add_index "change_teacher_logs", ["prev_teacher_id"], :name => "index_change_teacher_logs_on_prev_teacher_id"

  create_table "ci_records", :force => true do |t|
    t.integer  "packing_list_id",               :null => false
    t.string   "sn",              :limit => 64, :null => false
    t.integer  "vendor_id",                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ci_records", ["packing_list_id", "sn"], :name => "index_ci_records_on_packing_list_id_and_sn", :unique => true

  create_table "classroomwork_questions", :force => true do |t|
    t.string   "content"
    t.integer  "student_classroomworks_exercise_id"
    t.integer  "user_id"
    t.integer  "parent_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "classroomwork_questions", ["parent_id"], :name => "index_classroomwork_questions_on_parent_id"
  add_index "classroomwork_questions", ["user_id"], :name => "index_classroomwork_questions_on_user_id"

  create_table "classroomworks", :force => true do |t|
    t.integer  "course_id"
    t.datetime "end_time"
    t.string   "enjoin"
    t.integer  "lesson_id"
    t.integer  "book_id"
    t.integer  "num"
    t.string   "status"
    t.integer  "section_id"
    t.integer  "grades_course_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "classroomworks", ["grades_course_id"], :name => "index_classroomworks_on_grades_course_id"
  add_index "classroomworks", ["section_id"], :name => "index_classroomworks_on_section_id"

  create_table "classroomworks_exercises", :id => false, :force => true do |t|
    t.integer "exercise_id"
    t.integer "classroomwork_id"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "dd", :id => false, :force => true do |t|
    t.string   "fb_id",    :limit => 32
    t.integer  "count(*)", :limit => 8,  :default => 0, :null => false
    t.datetime "c"
    t.datetime "up"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "deletesn", :id => false, :force => true do |t|
    t.string  "s", :limit => 32
    t.integer "c"
  end

  create_table "devices", :force => true do |t|
    t.string   "sn",                        :limit => 64,                    :null => false
    t.integer  "vendor_id",                                                  :null => false
    t.string   "model_code",                :limit => 32, :default => "",    :null => false
    t.integer  "location_id"
    t.string   "shipment_status",           :limit => 11,                    :null => false
    t.string   "wipe_status",               :limit => 10
    t.datetime "wipe_in_at"
    t.datetime "wipe_out_at"
    t.string   "test_status",               :limit => 10
    t.datetime "test_in_at"
    t.datetime "test_out_at"
    t.integer  "packing_list_id"
    t.datetime "shipped_in_at"
    t.datetime "shipped_out_at"
    t.boolean  "deleted",                                 :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "receiving_scan",                          :default => false, :null => false
    t.string   "wipe_log",                                :default => "",    :null => false
    t.float    "capacity",                                :default => 0.0,   :null => false
    t.string   "ex",                        :limit => 32, :default => "",    :null => false
    t.string   "part_number",               :limit => 32, :default => "",    :null => false
    t.integer  "cycle",                                                      :null => false
    t.boolean  "white_glove",                             :default => false, :null => false
    t.boolean  "special_drive",                           :default => false, :null => false
    t.string   "fb_id",                     :limit => 32
    t.integer  "fb_cycle"
    t.datetime "fb_receiving_confirmed_at"
    t.datetime "fb_certificate_created_at"
    t.string   "fb_cert_id",                :limit => 32
    t.datetime "fb_wipe_result_sent_at"
    t.datetime "fb_test_result_sent_at"
    t.datetime "fb_erad_status_sent_at"
    t.string   "fb_cert_type",              :limit => 4
    t.string   "fb_erad_status",            :limit => 32
    t.string   "fb_part_number",            :limit => 32, :default => "",    :null => false
    t.string   "asset_host_name",           :limit => 64
  end

  add_index "devices", ["capacity"], :name => "capacity"
  add_index "devices", ["location_id"], :name => "index_devices_on_location_id"
  add_index "devices", ["model_code"], :name => "index_devices_on_model_code"
  add_index "devices", ["packing_list_id"], :name => "index_devices_on_packing_list_id"
  add_index "devices", ["shipped_in_at"], :name => "index_devices_on_shipped_in_at"
  add_index "devices", ["sn"], :name => "index_devices_on_sn"
  add_index "devices", ["test_status"], :name => "index_devices_on_test_status"
  add_index "devices", ["vendor_id", "location_id", "wipe_status", "test_status"], :name => "combined_index"
  add_index "devices", ["wipe_status"], :name => "index_devices_on_wipe_status"

  create_table "devices_archive", :force => true do |t|
    t.string   "sn",                        :limit => 64,                     :null => false
    t.integer  "vendor_id",                                                   :null => false
    t.string   "model_code",                :limit => 32,  :default => "",    :null => false
    t.integer  "location_id"
    t.string   "shipment_status",           :limit => 11,                     :null => false
    t.string   "wipe_status",               :limit => 10
    t.datetime "wipe_in_at"
    t.datetime "wipe_out_at"
    t.string   "test_status",               :limit => 10
    t.datetime "test_in_at"
    t.datetime "test_out_at"
    t.integer  "packing_list_id"
    t.datetime "shipped_in_at"
    t.datetime "shipped_out_at"
    t.boolean  "deleted",                                  :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "receiving_scan",                           :default => false, :null => false
    t.string   "wipe_log",                                 :default => "",    :null => false
    t.float    "capacity",                                 :default => 0.0,   :null => false
    t.string   "ex",                        :limit => 32,  :default => "",    :null => false
    t.string   "part_number",               :limit => 32,  :default => "",    :null => false
    t.integer  "cycle",                                                       :null => false
    t.boolean  "white_glove",                              :default => false, :null => false
    t.boolean  "special_drive",                            :default => false, :null => false
    t.string   "fb_id",                     :limit => 32
    t.integer  "fb_cycle"
    t.datetime "fb_receiving_confirmed_at"
    t.datetime "fb_certificate_created_at"
    t.string   "fb_cert_id",                :limit => 32
    t.datetime "fb_wipe_result_sent_at"
    t.datetime "fb_test_result_sent_at"
    t.datetime "fb_erad_status_sent_at"
    t.string   "fb_cert_type",              :limit => 4
    t.string   "fb_erad_status",            :limit => 32
    t.string   "fb_part_number",            :limit => 32,  :default => "",    :null => false
    t.string   "asset_host_name",           :limit => 64
    t.string   "notes",                     :limit => 256
  end

  add_index "devices_archive", ["capacity"], :name => "capacity"
  add_index "devices_archive", ["location_id"], :name => "index_devices_on_location_id"
  add_index "devices_archive", ["model_code"], :name => "index_devices_on_model_code"
  add_index "devices_archive", ["packing_list_id"], :name => "index_devices_on_packing_list_id"
  add_index "devices_archive", ["shipped_in_at"], :name => "index_devices_on_shipped_in_at"
  add_index "devices_archive", ["sn"], :name => "index_devices_on_sn"
  add_index "devices_archive", ["test_status"], :name => "index_devices_on_test_status"
  add_index "devices_archive", ["vendor_id", "location_id", "wipe_status", "test_status"], :name => "combined_index"
  add_index "devices_archive", ["wipe_status"], :name => "index_devices_on_wipe_status"

  create_table "exercise_options", :force => true do |t|
    t.text     "name"
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
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "title"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "section_id"
  end

  create_table "exercises", :force => true do |t|
    t.text     "title"
    t.text     "note"
    t.text     "answer"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "category_id"
    t.integer  "book_id"
    t.integer  "qtype_id"
    t.integer  "exercise_text_id"
    t.integer  "section_id"
    t.string   "answerphoto_file_name"
    t.string   "answerphoto_content_type"
    t.integer  "answerphoto_file_size"
    t.datetime "answerphoto_updated_at"
    t.text     "extra",                    :limit => 2147483647
  end

  create_table "exercises_homeworks", :id => false, :force => true do |t|
    t.integer "exercise_id"
    t.integer "homework_id"
  end

  create_table "extra_locations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grade_students", :force => true do |t|
    t.integer  "student_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "is_accept"
    t.integer  "grade_id"
  end

  add_index "grade_students", ["grade_id"], :name => "index_grade_students_on_grade_id"
  add_index "grade_students", ["student_id"], :name => "index_grade_students_on_student_id"

  create_table "grades", :force => true do |t|
    t.integer  "grade_num"
    t.integer  "class_num"
    t.string   "full_name"
    t.integer  "period_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "school_id"
  end

  add_index "grades", ["period_id"], :name => "index_grades_on_period_id"
  add_index "grades", ["school_id"], :name => "index_grades_on_school_id"

  create_table "grades_courses", :force => true do |t|
    t.integer  "course_id"
    t.boolean  "is_open"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "lesson_num"
    t.integer  "teacher_id"
    t.text     "outline"
    t.integer  "grade_id"
    t.boolean  "is_accept"
    t.integer  "book_id"
    t.integer  "period_id"
    t.boolean  "is_delete",  :default => false
  end

  add_index "grades_courses", ["book_id"], :name => "index_grades_courses_on_book_id"
  add_index "grades_courses", ["course_id"], :name => "index_grades_courses_on_course_id"
  add_index "grades_courses", ["grade_id"], :name => "index_grades_courses_on_grade_id"
  add_index "grades_courses", ["period_id"], :name => "index_grades_courses_on_period_id"

  create_table "homeworks", :force => true do |t|
    t.datetime "end_time"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "enjoin"
    t.integer  "lesson_id"
    t.integer  "book_id"
    t.integer  "num"
    t.string   "status"
    t.integer  "section_id"
    t.integer  "grades_course_id"
  end

  add_index "homeworks", ["grades_course_id"], :name => "index_homeworks_on_grades_course_id"
  add_index "homeworks", ["section_id"], :name => "index_homeworks_on_section_id"

  create_table "ips", :force => true do |t|
    t.integer  "user_id",                  :null => false
    t.string   "ip",         :limit => 16, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ips", ["user_id"], :name => "index_ips_on_user_id"

  create_table "jyjs", :force => true do |t|
    t.string   "name"
    t.string   "post_code"
    t.string   "address"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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

  create_table "locations", :force => true do |t|
    t.string   "label",           :limit => 10,                     :null => false
    t.string   "contact_name",    :limit => 64,                     :null => false
    t.string   "email",           :limit => 32,                     :null => false
    t.string   "phone",           :limit => 32
    t.string   "address",         :limit => 128
    t.string   "city",            :limit => 64
    t.string   "state",           :limit => 32
    t.string   "country",         :limit => 32
    t.string   "zip",             :limit => 10
    t.boolean  "deleted",                        :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_zone_name",  :limit => 28,                     :null => false
    t.integer  "num_wipe_system"
    t.integer  "num_test_system"
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
    t.boolean  "is_accept"
    t.integer  "grade_id"
    t.integer  "school_id"
    t.integer  "course_id"
    t.integer  "period_id"
  end

  add_index "messages", ["course_id"], :name => "index_messages_on_course_id"
  add_index "messages", ["grade_id"], :name => "index_messages_on_grade_id"
  add_index "messages", ["parent_id"], :name => "index_messages_on_parent_id"
  add_index "messages", ["period_id"], :name => "index_messages_on_period_id"
  add_index "messages", ["school_id"], :name => "index_messages_on_school_id"

  create_table "model_attrs", :force => true do |t|
    t.string   "name",       :limit => 32,                    :null => false
    t.string   "value",      :limit => 32,                    :null => false
    t.boolean  "deleted",                  :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "model_attrs", ["name", "value"], :name => "index_model_attrs_on_name_and_value"

  create_table "models", :force => true do |t|
    t.string   "code",            :limit => 32
    t.integer  "manufacturer_id"
    t.integer  "ex_id"
    t.integer  "interface_id"
    t.integer  "size_id"
    t.integer  "capacity_id"
    t.boolean  "deleted",                       :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", :force => true do |t|
    t.string   "event",      :limit => 64
    t.string   "role",       :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "device_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "operations", ["device_id"], :name => "index_operations_on_device_id"
  add_index "operations", ["name"], :name => "index_operations_on_name"
  add_index "operations", ["user_id"], :name => "index_operations_on_user_id"

  create_table "packing_lists", :force => true do |t|
    t.string   "code",        :limit => 64, :null => false
    t.string   "kind",        :limit => 16, :null => false
    t.integer  "user_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "packing_lists", ["code"], :name => "index_packing_lists_on_code"
  add_index "packing_lists", ["kind", "code"], :name => "index_packing_lists_on_kind_and_code"

  create_table "part_numbers", :force => true do |t|
    t.string   "code",            :limit => 32,                    :null => false
    t.boolean  "universal_spare",               :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "periods", :force => true do |t|
    t.string   "full_name"
    t.string   "start_year"
    t.string   "end_year"
    t.string   "desc"
    t.boolean  "is_current"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "qtypes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "content"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "student_homeworks_exercise_id"
    t.integer  "user_id"
    t.integer  "parent_id"
  end

  add_index "questions", ["parent_id"], :name => "index_questions_on_parent_id"
  add_index "questions", ["student_homeworks_exercise_id"], :name => "index_questions_on_student_homeworks_exercise_id"
  add_index "questions", ["user_id"], :name => "index_questions_on_teacher_id"
  add_index "questions", ["user_id"], :name => "index_questions_on_user_id"

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
    t.string   "post_code"
    t.string   "address"
    t.integer  "jyj_id"
  end

  add_index "schools", ["jyj_id"], :name => "index_schools_on_jyj_id"

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "book_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "number"
    t.integer  "num"
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

  create_table "sn_temp", :id => false, :force => true do |t|
    t.string "sn", :limit => 64, :null => false
  end

  create_table "stu_grade_courses", :force => true do |t|
    t.string   "score"
    t.string   "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "student_classroomworks", :force => true do |t|
    t.integer  "student_id"
    t.integer  "classroomwork_id"
    t.string   "status"
    t.string   "score"
    t.string   "level"
    t.string   "ask_note"
    t.integer  "times"
    t.datetime "first_update"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "student_classroomworks_exercises", :id => false, :force => true do |t|
    t.integer "id", :null => false
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
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "score"
    t.string   "level"
    t.string   "ask_note"
    t.integer  "times",        :default => 0
    t.datetime "first_update"
  end

  create_table "student_homeworks_exercises", :force => true do |t|
    t.integer  "student_homework_id"
    t.integer  "exercise_id"
    t.text     "canvas"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.text     "answer"
    t.integer  "teacher_id"
    t.string   "check_desc"
  end

  add_index "student_homeworks_exercises", ["exercise_id"], :name => "index_student_homeworks_exercises_on_exercise_id"
  add_index "student_homeworks_exercises", ["student_homework_id"], :name => "index_student_homeworks_exercises_on_student_homework_id"
  add_index "student_homeworks_exercises", ["teacher_id"], :name => "index_student_homeworks_exercises_on_teacher_id"

  create_table "system_events", :force => true do |t|
    t.string   "path",       :limit => 64
    t.integer  "user_id"
    t.boolean  "post"
    t.boolean  "xhr"
    t.string   "remote_ip",  :limit => 16
    t.datetime "created_at"
  end

  add_index "system_events", ["created_at"], :name => "index_system_events_on_created_at"
  add_index "system_events", ["user_id"], :name => "index_system_events_on_user_id"

  create_table "t", :id => false, :force => true do |t|
    t.string "sn",       :limit => 64
    t.string "part",     :limit => 64
    t.string "capacity", :limit => 64
  end

  add_index "t", ["sn"], :name => "sn", :unique => true

  create_table "t5", :id => false, :force => true do |t|
    t.integer "id"
  end

  create_table "teches", :force => true do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tins", :id => false, :force => true do |t|
    t.string "sn",          :limit => 32
    t.string "wipe_result", :limit => 32
    t.string "test_result", :limit => 32
  end

  add_index "tins", ["sn"], :name => "sn", :unique => true

  create_table "tiny_prints", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_file_size"
    t.string   "image_content_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "tiny_videos", :force => true do |t|
    t.string   "original_file_name"
    t.string   "original_file_size"
    t.string   "original_content_type"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "tt", :id => false, :force => true do |t|
    t.string "sn",             :limit => 64,                 :null => false
    t.string "part_number",    :limit => 32, :default => "", :null => false
    t.string "fb_part_number", :limit => 32, :default => "", :null => false
    t.string "capacity",       :limit => 32, :default => "", :null => false
  end

  add_index "tt", ["sn"], :name => "sn", :unique => true

  create_table "ttt", :id => false, :force => true do |t|
    t.string  "sn",       :limit => 32
    t.string  "loc",      :limit => 32
    t.string  "result",   :limit => 32
    t.string  "tresult",  :limit => 32
    t.string  "pn",       :limit => 32
    t.integer "capacity"
    t.integer "id"
  end

  add_index "ttt", ["id"], :name => "id", :unique => true
  add_index "ttt", ["sn"], :name => "sn", :unique => true

  create_table "ttt3", :id => false, :force => true do |t|
    t.string  "sn",       :limit => 32
    t.string  "loc",      :limit => 32
    t.string  "result",   :limit => 32
    t.string  "tresult",  :limit => 32
    t.string  "pn",       :limit => 32
    t.integer "capacity"
    t.integer "id"
  end

  add_index "ttt3", ["id"], :name => "id", :unique => true
  add_index "ttt3", ["sn"], :name => "sn", :unique => true

  create_table "ttt4", :id => false, :force => true do |t|
    t.string  "sn",       :limit => 32
    t.string  "loc",      :limit => 32
    t.string  "result",   :limit => 32
    t.string  "tresult",  :limit => 32
    t.string  "pn",       :limit => 32
    t.integer "capacity"
    t.integer "id"
  end

  add_index "ttt4", ["id"], :name => "id", :unique => true
  add_index "ttt4", ["sn"], :name => "sn", :unique => true

  create_table "upload_files", :force => true do |t|
    t.string   "name"
    t.integer  "exercise_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",  :null => false
    t.string   "encrypted_password",     :default => "",  :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,   :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "login"
    t.string   "gender"
    t.string   "phone"
    t.string   "auth_code"
    t.integer  "school_id"
    t.integer  "role_id"
    t.string   "real_name"
    t.string   "bg_num",                 :default => "0"
    t.integer  "jyj_id"
  end

  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "message_id"
    t.string   "status",     :default => "open"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "users_messages", ["message_id"], :name => "index_users_messages_on_message_id"
  add_index "users_messages", ["user_id"], :name => "index_users_messages_on_user_id"

  create_table "vacations", :force => true do |t|
    t.integer  "user_id",                                          :null => false
    t.datetime "date_from",                                        :null => false
    t.datetime "date_to",                                          :null => false
    t.string   "reported_to",    :limit => 64,                     :null => false
    t.string   "reason",         :limit => 128,                    :null => false
    t.boolean  "approved",                      :default => false, :null => false
    t.integer  "vacation_hours",                :default => 0
    t.integer  "sick_hours",                    :default => 0
    t.string   "approved_by",    :limit => 128
    t.boolean  "sick_leave",                    :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendors", :force => true do |t|
    t.string   "label",         :limit => 32,                    :null => false
    t.string   "name",          :limit => 32,                    :null => false
    t.boolean  "separate_cod",                :default => false, :null => false
    t.boolean  "deleted",                     :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "no_test",                     :default => false, :null => false
    t.boolean  "wipe_eligible"
  end

end
