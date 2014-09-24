class Option < ActiveRecord::Base
	# 选项与试题的关联
	belongs_to :question

	attr_accessible :question_id, :body, :correct, :select_num

	def select_num_plus
		self.select_num += 1
	end

end
