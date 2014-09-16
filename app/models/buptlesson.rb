class Buptlesson < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :buptlesson_id, :course_id, :lesson_num, :lesson_name, :lesson_pic, :lesson_goal, :lesson_difficulty, :lesson_website

    belongs_to :buptcourse
end
