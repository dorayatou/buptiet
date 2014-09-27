class Answer < ActiveRecord::Base
	# 回答与学生的关联
	belongs_to :student 
	# 答案与试题的关联
	belongs_to :question
	
  attr_accessible :student_id, :question_id, :option_id, :correct, :quiz_id, :fav_flag
	
	def correct?(student_id, question_id, correct)
		where('student_id = ? and question_id = ? and correct = ?', student_id, question_id, correct)
	end

	def fav?(student_id, question_id, fav_flag)
		where('student_id = ? and question_id = ? and fav_flag = ?', student_id, question_id, 't').present?
	end

end
