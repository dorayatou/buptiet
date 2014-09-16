class Course < ActiveRecord::Base
	# 课程与教师的多对多关系，通过offer
	has_many :offers, dependent: :destroy
	has_many :teachers, through: :offers
	
	# 课程与学生的多对多关系
	has_and_belongs_to_many :students

	# 课程与上课或者授课时间的关系
	has_many :course_times, dependent: :destroy

	belongs_to :academy

	has_many :quizzes, dependent: :destroy


	attr_accessible :name, :identifier, :kind, :academy_id, :info, :tag, :image
end
