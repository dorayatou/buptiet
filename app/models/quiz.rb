class Quiz < ActiveRecord::Base
	# 随堂测试与教师关联
	belongs_to :teacher
	# 随堂测试与试题的一对多的关系
	has_many :questions

	belongs_to :course

	attr_accessible :teacher_id, :course_id, :quiz_time, :week_total, :seq, :name, :quiz_type

	def quiz_list(course_id)
		Quiz.where('course_id = ?', course_id)
	end

	def quiz_question_list
		Question.where('quiz_id = ?', self.id).map(&:id)
	end

	def quiz_question_list_num
		questions.map(&:id)
	end

	def quiz_question_number
		quiz_question_list.size
	end

	def quiz_first_question
		quiz_question_list[0]
	end

		
end
