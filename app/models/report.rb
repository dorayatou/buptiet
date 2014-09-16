class Report < ActiveRecord::Base
  attr_accessible :student_id, :course_name, :learning_time
end
