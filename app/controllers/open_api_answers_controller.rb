class OpenApiAnswersController < ApplicationController
	def open_question_answer
		@answer = OpenApiAnswer.new
		@current_session  =  OpenCurrentQuestion.last
		@answer.quiz_id  =  @current_session.quiz_id
		@answer.question_id  =  @current_session.question_id
		#@answer.quiz_id = session[:current_quiz]
		#@answer.question_id = session[:current_question]
		@answer.student_id = params[:student_id]
		@answer.option_id = params[:answer_id]

		#@current_question = Question.find(session[:current_question])
		@current_question  =  Question.find(@current_session.question_id)
		if 	@current_question.correct_option == params[:answer_id]
			@answer.correct = true
		else
			@answer.correct = false
		end
		
		if @answer.save
			render(:text => "success")
		else
			render(:text => "fail")
		end
	end

	def open_answers
		@current_session  =  OpenCurrentQuestion.last
		@current_quiz = Quiz.find(@current_session.quiz_id)
		@question_num_list = @current_quiz.quiz_question_list_num
		@questions = @current_quiz.questions	
	end

	def test
	end
end
