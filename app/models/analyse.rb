class Analyse < ActiveRecord::Base
	# 分析与试题的关联
	belongs_to :question

	attr_accessible :question_id, :body, :detail
end