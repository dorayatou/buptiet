class CourseStudent < ActiveRecord::Base
	attr_accessible :course_id, :student_id, :grade
end