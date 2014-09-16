class Question < ActiveRecord::Base
	# 试题与随堂测试的关联
	belongs_to :quiz
	# 试题与选项的一对多关系
	has_many :options
	# 试题与分析的一对一关系
	has_one :analyse
	# 试题与答案之间的一对一关系
	has_one :answer
	
   attr_accessible :quiz_id, :question_type, :body, :total_num, :correct_num, :fav_flag
end
