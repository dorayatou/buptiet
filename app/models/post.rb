class Post < ActiveRecord::Base
	# 消息与学生的关联
	belongs_to :student
	# 消息与教师的关联
	belongs_to :teacher
	
	belongs_to :blog
	has_many :comments, order: :"created_at", dependent: :destroy

	attr_accessible :title, :body
end
