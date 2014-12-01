module OpenApiAnswersHelper
	def question_list(question_id)
		 OpenApiAnswer.where('question_id = ?', question_id)
	end

	 def answer_num_of_question(question_id)
		 question_list(question_id).size
	 end

	 def correct_num(question_id)
		 question_list(question_id).where('correct = ?', true).size
	 end

	 def correct_rate(question_id)
	 	if answer_num_of_question(question_id) != 0
		 	correct_num(question_id).to_f / answer_num_of_question(question_id).to_f * 100 
		else
			0
		end
	 end
end
