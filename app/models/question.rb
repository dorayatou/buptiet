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

	def self.question_list(quiz_id)
		where('quiz_id = ?', quiz_id).map(&:id)
	end

	def option_tags
		Option.where('question_id = ?', self.id).map(&:id)
	end

	def correct
		Option.where('question_id = ? and correct = ?', self.id, true).pluck(:id)[0]
	end

	def total_num_plus
		self.total_num += 1
	end

	def correct_num_plus
		self.total_num += 1
	end

	def question_list
		Question.where('quiz_id = ?', self.quiz_id).map(&:id)
	end

	def pre_question_id
		if self.index == 0
			return nil
		end
		question_list[index-1]
	end

	def next_question_id
		len = self.question_list.size
		if self.index == len
			 return nil
		end
    question_list[index+1]
	end

	def index
	  len = self.question_list.size
	  i = 0;
		while i < len do
			if question_list[i] == self.id
				return i
			end
			i += 1
		end
	end

	
end
