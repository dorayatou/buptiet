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

ActiveRecord::Schema.define(:version => 20140916071209) do

  create_table "academies", :force => true do |t|
    t.string   "identifier"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "admin_infos", :force => true do |t|
    t.integer  "admin_id"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "admins", :force => true do |t|
    t.string   "identifier"
    t.string   "password"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "analyses", :force => true do |t|
    t.integer  "question_id"
    t.text     "body"
    t.text     "detail"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "answer_student_lists", :force => true do |t|
    t.integer  "problem_id"
    t.integer  "student_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "answers", :force => true do |t|
    t.integer  "student_id"
    t.integer  "quiz_id"
    t.integer  "question_id"
    t.integer  "option_id"
    t.boolean  "correct",     :default => false
    t.boolean  "fav_flag",    :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "buptcomments", :primary_key => "buptcomment_id", :force => true do |t|
    t.integer  "buptcourse_id",   :default => 0
    t.integer  "buptlesson_id",   :default => 0
    t.text     "user_name"
    t.text     "comment_content"
    t.text     "comment_time"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "buptcourses", :primary_key => "buptcourse_id", :force => true do |t|
    t.text     "course_type"
    t.text     "course_name"
    t.text     "course_lecturer"
    t.text     "course_lecturer_intro"
    t.text     "course_intro"
    t.text     "course_image"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "buptexercises", :primary_key => "buptexercise_id", :force => true do |t|
    t.integer  "buptcourse_id"
    t.integer  "buptlesson_id"
    t.text     "question_type"
    t.integer  "question_num"
    t.text     "question"
    t.text     "option_a"
    t.text     "option_b"
    t.text     "option_c"
    t.text     "option_d"
    t.text     "answer"
    t.text     "analysis"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "buptfavorites", :primary_key => "buptfavo_id", :force => true do |t|
    t.text     "user_name"
    t.integer  "buptcourse_id"
    t.text     "course_name"
    t.text     "favo_time"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "buptlessons", :primary_key => "buptlesson_id", :force => true do |t|
    t.integer  "buptcourse_id"
    t.integer  "lesson_num"
    t.text     "lesson_name"
    t.text     "lesson_pic"
    t.text     "lesson_goal"
    t.text     "lesson_difficulty"
    t.text     "lesson_website"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "buptplaying_exercises", :primary_key => "buptplaying_exercise_id", :force => true do |t|
    t.integer  "buptlesson_id"
    t.text     "question_type"
    t.integer  "question_num"
    t.integer  "pause_time"
    t.text     "question"
    t.text     "option_a"
    t.text     "option_b"
    t.text     "option_c"
    t.text     "option_d"
    t.text     "answer"
    t.text     "analysis"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "buptusers", :primary_key => "user_id", :force => true do |t|
    t.text     "user_name"
    t.text     "password"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "student_id"
    t.integer  "post_id"
    t.string   "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "course_students", :force => true do |t|
    t.integer  "course_id"
    t.integer  "student_id"
    t.text     "grade"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "course_times", :force => true do |t|
    t.integer  "course_id"
    t.string   "weekday"
    t.string   "period"
    t.integer  "year"
    t.integer  "month"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "courses", :force => true do |t|
    t.integer  "academy_id"
    t.string   "identifier"
    t.string   "name"
    t.string   "info"
    t.string   "image"
    t.string   "tag"
    t.string   "kind"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "courses_students", :id => false, :force => true do |t|
    t.integer "course_id",  :null => false
    t.integer "student_id", :null => false
  end

  create_table "courses_teachers", :id => false, :force => true do |t|
    t.integer  "course_id",   :null => false
    t.integer  "teacher_id",  :null => false
    t.integer  "offer_id",    :null => false
    t.integer  "schedule_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "favourites", :force => true do |t|
    t.integer  "student_id"
    t.integer  "question_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "file_serves", :force => true do |t|
    t.integer  "course_id"
    t.string   "title"
    t.string   "file_name"
    t.string   "file_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "finding_tone_scores", :force => true do |t|
    t.text     "target_tone_char"
    t.text     "compare_tone_char"
    t.integer  "consume_time"
    t.boolean  "correct"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "student_id"
  end

  create_table "group_members", :id => false, :force => true do |t|
    t.integer  "group_id"
    t.integer  "student_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "course_id"
    t.integer  "academy_id"
    t.string   "kind"
    t.string   "identifier"
    t.string   "name"
    t.text     "intro"
    t.text     "tag"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups_students", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "student_id"
  end

  create_table "image_courses", :force => true do |t|
    t.string   "question_num"
    t.string   "question_item"
    t.string   "score_item"
    t.integer  "score"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "iq_tests", :force => true do |t|
    t.string   "question_num"
    t.string   "question_item"
    t.string   "score_item"
    t.integer  "score"
    t.string   "consume_time"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "student_id"
    t.integer  "post_id"
    t.integer  "comment_id"
    t.boolean  "read"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "offers", :force => true do |t|
    t.string   "identifier"
    t.integer  "course_id"
    t.integer  "teacher_id"
    t.string   "address"
    t.date     "begin"
    t.date     "end"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "opinions", :force => true do |t|
    t.integer  "topic_id"
    t.string   "body"
    t.integer  "select_count", :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "options", :force => true do |t|
    t.integer  "question_id"
    t.text     "body"
    t.boolean  "correct",     :default => false
    t.integer  "select_num",  :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "playing_tone_scores", :force => true do |t|
    t.text     "target_tone_char"
    t.integer  "consume_time"
    t.boolean  "correct"
    t.text     "selected_tone_char"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "student_id"
  end

  create_table "posts", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "student_id"
    t.integer  "group_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "practice_tone_scores", :force => true do |t|
    t.text     "first_tone_char"
    t.text     "second_tone_char"
    t.integer  "consume_time"
    t.boolean  "correct"
    t.boolean  "is_covered"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "student_id"
  end

  create_table "previews", :force => true do |t|
    t.integer  "course_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "problems", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "student_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "number"
  end

  create_table "questions", :force => true do |t|
    t.integer  "quiz_id"
    t.string   "question_type"
    t.text     "body"
    t.integer  "total_num",     :default => 0
    t.integer  "correct_num",   :default => 0
    t.boolean  "fav_flag",      :default => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "quizzes", :force => true do |t|
    t.integer  "course_id"
    t.integer  "teacher_id"
    t.string   "quiz_type"
    t.integer  "seq"
    t.string   "name"
    t.integer  "quiz_time"
    t.integer  "week_total"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "replies", :force => true do |t|
    t.integer  "problem_id"
    t.integer  "student_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reports", :force => true do |t|
    t.integer  "student_id"
    t.string   "course_name"
    t.string   "learning_time"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "quiz_id"
  end

  create_table "selects", :force => true do |t|
    t.integer  "offer_id"
    t.integer  "student_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "student_infos", :force => true do |t|
    t.integer  "student_id"
    t.string   "nick"
    t.string   "name"
    t.string   "email"
    t.integer  "academy_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "students", :force => true do |t|
    t.string   "identifier"
    t.string   "password"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "students_teachers", :id => false, :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "student_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teacher_infos", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "academy_id"
    t.string   "nick"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teachers", :force => true do |t|
    t.string   "identifier"
    t.string   "password"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "topics", :force => true do |t|
    t.integer  "teacher_id"
    t.text     "body"
    t.integer  "cast_count"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "votes", :force => true do |t|
    t.integer  "student_id"
    t.integer  "topic_id"
    t.integer  "opinion_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
