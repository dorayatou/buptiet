class CourseTime < ActiveRecord::Base
	# 课程时间与课程的关系
	belongs_to :course 
	
    attr_accessible :course_id, :weekday, :period, :year, :month
end
