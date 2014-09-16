class QuestionsController < ApplicationController
	include ApplicationHelper
	# before_filter :admin_protect, :onle => [:new, :create]

	# before_filter :teacher_protect, :only => "index, show, new, create, edit, update"
	# # 教师登陆进去的quiz页面中的所有问题
	# def index
	# 	@course = Course.find(params[:course_id])
	# 	@quiz = Quiz.find(params[:quiz_id])
	# 	@questions = @quiz.questions
	# end

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

	def update
		
	end
	

	# def teacher_protect
	# 	if not (session[:teacher_id])
 #      		redirect_to buptiet_url, :alert => "login!"
 #      		return false
 #    	end
	# end

	def admin_protect
		if session[:admin_id].nil?
			redirect_to buptiet_url, :alter => "Login!"
			return false
		end
	end

end
