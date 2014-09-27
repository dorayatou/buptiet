class QuestionsController < ApplicationController
	def index
		@current_course = Course.find(params[:course_id])
		@current_quiz = Quiz.find(params[:quiz_id])
		@questions = @current_quiz.questions
	end
	# 教师登陆进去展示一个question
	def show
		@current_course = Course.find(params[:course_id])
		@current_quiz = Quiz.find(params[:quiz_id])
		@question = Question.find(params[:id])
		@options = @question.options
		@option_all_tags = ["A", "B", "C", "D", "E", "F"]
		@analyse = Analyse.find_by_question_id(@question.id)
	end

	def student_show_question
		@exercise = Quiz.find(params[:exercise_id])
		@question = Quiz.find(params[:question_id])
		@options = @question.options
		@option_all_tags = ["A", "B", "C", "D", "E", "F"]
	end

	def new
		@current_course = Course.find(params[:course_id])
		@current_quiz = Quiz.find(params[:quiz_id])
		@question = Question.new
	end

	def create
		@question = Question.new(params[:question])
		@current_course = Course.find(params[:course_id])
		@current_quiz = Quiz.find(params[:quiz_id])
		@question.quiz_id = @current_quiz.id
		@question.total_num = 0
		@question.correct_num = 0
		@question.fav_flag = 'f'

		respond_to do |format|
			if @question.save
				format.html {  redirect_to course_quiz_question_path(@current_course, @current_quiz, @question), :notice => "success." }
			else
				format.html { redirect_to :action => "new" }
			end
		end
	end

	def edit
		@quiz = Quiz.find_by_id(params[:quiz_id])
		@question = Question.find(params[:id])
	end

end
