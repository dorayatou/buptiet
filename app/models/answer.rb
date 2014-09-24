class Answer < ActiveRecord::Base
	# 回答与学生的关联
	belongs_to :student 
	# 答案与试题的关联
	belongs_to :question
	
  attr_accessible :student_id, :question_id, :option_id, :correct, :quiz_id, :fav_flag

end
