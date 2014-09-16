class Vote < ActiveRecord::Base
	# 选票与学生的关联
	belongs_to :student
	# 选票与话题的关联
	belongs_to :topic
	# 选票与投票箱的关联
	# belongs_to :box
	
    attr_accessible :opinion_id, :box_id, :quantity, :student_id, :topic_id
end
