class OpenApiAnswersController < ApplicationController
	def open_question_answer
		@answer = OpenApiAnswer.new
		@answer.quiz_id = session[:current_quiz]
		@answer.question_id = session[:current_question]
		@answer.student_id = params[:student_id]
		
		@answer.option_id = params[:answer_id]
		@current_question = Question.find(session[:current_question])
		if 	@current_question.correct_option == params[:answer_id]
			@answer.correct = true
		else
			@answer.correct = false
		end
		@answer.save
	end

	def open_answers
		@current_quiz = Quiz.find(session[:current_quiz])
		@question_num_list = @current_quiz.quiz_question_list_num
		@questions = @current_quiz.questions	
	end

	def test
	end
end
