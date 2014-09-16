class OptionsController < ApplicationController
	include ApplicationHelper
	# before_filter :admin_protect

	def new
		@option = Option.new
		@current_course = Course.find(params[:course_id])
		@current_quiz = Quiz.find(params[:quiz_id])
		@question = Question.find(params[:question_id])
	end

	def create
		@option = Option.new(params[:option])
		@current_course = Course.find(params[:course_id])
		@current_quiz = Quiz.find(params[:quiz_id])
		@question = Question.find(params[:question_id])
		@option.question_id = params[:question_id]
		@option.select_num = 0

		respond_to do |format|
			if @option.save
				format.html { redirect_to new_course_quiz_question_option_path(@current_course.id, @current_quiz.id, @question.id), :notice => "#{@question.options.count} options" }
			else
				format.html { render :action => "new"}
			end
		end

	end

	def admin_protect
		if session[:admin_id].nil?
			redirect_to buptiet_url, :alter => "Login!"
			return false
		end
	end

end