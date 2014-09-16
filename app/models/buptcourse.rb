class Buptcourse < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :buptcourse_id, :course_type, :course_name, :course_lecturer, :course_lecturer_intro, :course_intro, :course_image
  
    has_many :buptlessons
end
