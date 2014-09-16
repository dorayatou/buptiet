class Opinion < ActiveRecord::Base
	# 观点与话题的关联关系
	belongs_to :topic
	
    attr_accessible :topic_id, :body, :select_count
end
