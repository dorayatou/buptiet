class OpenApiAnswersController < ApplicationController
	def open_question_answer
		@answer = OpenApiAnswer.new
		@answer.quiz_id = session[:current_quiz]
		@answer.question_id = session[:current_question]
		@answer.student_id = params[:student_id]
		
		@answer.option_id = params[:option_id]
		@current_question = Question.find(session[:current_question])
		if 	@current_question.correct == params[:option_id]
			@answer.correct = true
		else
			@answer.correct = false
		end
		@answer.save
	end

	def open_answers
		@current_quiz = Quiz.find(session[:current_quiz])
		@questions = @current_quiz.questions	
	end
end
