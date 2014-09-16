class Reply < ActiveRecord::Base
	# 答复与问题的多对一的关系
	belongs_to :problem

  	# attr_accessible :title, :body
end
