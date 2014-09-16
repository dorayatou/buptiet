class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :teacher
	belongs_to :student

	attr_accessible :student_id, :teacher_id, :post_id, :body
end
