class Offer < ActiveRecord::Base
	# 连接教师与课程的中间模型offer
	belongs_to :course
	belongs_to :teacher
	attr_accessible :identifier, :course_id, :teacher_id, :address, :begin, :end
end
