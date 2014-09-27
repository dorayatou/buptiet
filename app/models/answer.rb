class Answer < ActiveRecord::Base
	# 回答与学生的关联
	belongs_to :student 
	# 答案与试题的关联
	belongs_to :question
	
  attr_accessible :student_id, :question_id, :option_id, :correct, :quiz_id, :fav_flag
	
	def self.correct?(student_id, question_id, correct)
		where('student_id = ? and question_id = ? and correct = ?', student_id, question_id, correct).present?
	end

	def self.fav?(student_id, question_id, fav_flag)
		where('student_id = ? and question_id = ? and fav_flag = ?', student_id, question_id, 't').present?
	end

	def self.number(student_id, quiz_id)
		where('student_id = ? and question_id =?', student_id, quiz_id).size 
	end

	def self.correct_num(student_id, quiz_id)
		where('student_id = ? and quiz_id = ? and correct = ?', student_id, quiz_id, 't').size
	end

	def self.wrong_question_list(student_id, quiz_id)
		where('student_id = ? and quiz_id = ? and correct = ?', student_id, quiz_id, 'f').map(&:question_id)
	end

end
