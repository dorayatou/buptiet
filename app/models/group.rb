class Group < ActiveRecord::Base
	# 群组与教师的多对一关系
	belongs_to :teacher
	# 群组与学生的多对多关系(中间表groups_students)
	has_and_belongs_to_many :students
	# 群组与消息的一对多关系（单向）
	has_many :posts

    attr_accessible :identifier, :name, :intro, :tag, :kind, :course_id, :academy_id, :teacher_id, :group_id
end
