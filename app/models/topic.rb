#encoding: utf-8
class Topic < ActiveRecord::Base
	# 话题与观点的一对多关系
	has_many :opinions, dependent: :destroy
	# 话题与选票的一对多关联
	has_many :votes
	# 观点与教师的关联
	belongs_to :teacher
	
	
    attr_accessible :teacher_id, :student_id, :body, :cast_count
end
