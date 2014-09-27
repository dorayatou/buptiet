class QuizzesController < ApplicationController
	# 教师登陆进去的quiz页面
	def teacher_quiz
		time = Time.now.to_a
		day = time[7]
		week_total = day/7 + 1
		@current_course = Course.find(session[:course_id])
		@quizzes = Quiz.where("course_id = ?", @current_course.id)
	    # @quizzes = Quiz.where("course_id = ? AND week_total = ?", @current_course.id, week_total)
	end

	def teacher_show_quiz
		@current_course = Course.find(session[:course_id])
		@current_quiz = Quiz.find(params[:quiz_id])
		@questions = Question.find_all_by_quiz_id(@current_quiz.id)
		@option_all_tags = ["A", "B", "C", "D", "E", "F"]
	end

	# 学生登陆进去的其他课程的quiz列表
	def student_other_test
		@select_course = Course.find(params[:course_id])
		@quizzes = @select_course.quizzes
	end

	# 管理员登陆进去的quiz页面
	def index
		time = Time.now.to_a
		day = time[7]
		week_total = day/7 + 1
		@current_course = Course.find(params[:course_id])
		@quizzes = Quiz.where("course_id = ?", @current_course.id)
	end

	def show
		@quiz = Quiz.find(params[:id])
	end

	def new
		@current_course = Course.find(params[:course_id])
		@quiz = Quiz.new
	end

	def create
		@quiz = Quiz.new(params[:quiz])
		@current_course = Course.find(params[:course_id])
		@quiz.course_id = @current_course.id

		respond_to do |format|
			if @quiz.save
				format.html { redirect_to  course_quiz_questions_path(@current_course, @quiz), :notice => "add" }
			else
				format.html { render :action => "new" }
			end
		end
	end

end
