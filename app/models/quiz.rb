class Quiz < ActiveRecord::Base
	# 随堂测试与教师关联
	belongs_to :teacher
	# 随堂测试与试题的一对多的关系
	has_many :questions

	belongs_to :course
	
    attr_accessible :teacher_id, :course_id, :quiz_time, :week_total, :seq, :name, :quiz_type
end
