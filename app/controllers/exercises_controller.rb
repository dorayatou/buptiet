class ExercisesController < ApplicationController
	include ApplicationHelper
	# before_filter :student_protect

	# 学生登陆进去展示当堂课的quiz,即exercises
	def index
		time = Time.now.to_a
		day = time[7]
		week_total = day/7 + 1
		@exercises = Quiz.where("course_id = ?", session[:course_id])
	    # @exercises = Quiz.where("course_id = ? AND week_total = ?", session[:course_id], week_total)
	end

	def show
		@exercise = Quiz.find(params[:exercise_id])
		@questions = @exercise.questions
		@question = @questions.first

		respond_to do |format|
			if not @questions.empty?
				format.html
			else
				format.html { redirect_to exercises_path, :notice => "no questions" }
			end
		end
	end

	# 学生其他选择的其他课程中的测试信息
	def student_other_course_quiz
		@select_course = Course.find(params[:course_id])
		@course_quizzes = @select_course.quizzes
	end

	def student_protect
		if session[:student_id].nil?
			redirect_to buptiet_url, :notice => "Login"
			return false
		end
	end
end