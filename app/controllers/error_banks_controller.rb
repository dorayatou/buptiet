class ErrorBanksController < ApplicationController
	def index
		@student = Student.find(session[:student_id])
		error_answer_ids = Answer.order(:question_id).where("student_id = ? AND correct = ?", @student.id, 'f').pluck(:question_id)
		@error_answer_num = error_answer_ids.size
		if @error_answer_num == 0
			@question = nil
		else
			@question = Question.find(error_answer_ids[0])
		end
	end

	def show
		@student = Student.find(session[:student_id])
		@current_question = Question.find(params[:question_id])
		@options = @current_question.options
		@option_all_tags = ["A", "B", "C", "D", "E", "F"]

		@analyse = Analyse.find_by_question_id(@current_question.id)

		if params[:option_id]
			@select_option = Option.find(params[:option_id])
		else
			@select_option = nil
		end

		error_answer_ids = Answer.order(:question_id).where("student_id = ? AND correct = ?", @student.id, 'f').pluck(:question_id)
		
		current_question_id = @current_question.id

		long = error_answer_ids.size
		min_index = 0
		max_index = long - 1
		
		indexs = (min_index..max_index).collect do |index|
			if error_answer_ids[index] == current_question_id
				current_index = index
			end
		end

		# 返回含有当前指针的数组，是数组
		current_index = indexs.compact

		# 上一题
		if current_index[0] > min_index
			pre_question_id = error_answer_ids[current_index[0] - 1]
			@pre_question = Question.find(pre_question_id)
		end

		# 下一题
		if current_index[0] < max_index
			next_question_id = error_answer_ids[current_index[0] + 1]
			@next_question = Question.find(next_question_id)
		end

		respond_to do |format|
			format.html
		end
		
	end

	# def show_error
	# 	@student = Student.find(session[:student_id])
	# 	@current_question = Question.find(params[:question_id])
	# 	@options = @current_question.options
	# 	@option_all_tags = ["A", "B", "C", "D", "E", "F"]

	# 	@analyse = Analyse.find_by_question_id(@current_question.id)

	# 	if params[:option_id]
	# 		@select_option = Option.find(params[:option_id])
	# 	else
	# 		@select_option = nil
	# 	end

	# 	current_question_id = @current_question.id

	# 	long = fav_question_ids.size
	# 	min_index = 0
	# 	max_index = long - 1
		
	# 	indexs = (min_index..max_index).collect do |index|
	# 		if fav_question_ids[index] == current_question_id
	# 			current_index = index
	# 		end
	# 	end

	# 	# 返回含有当前指针的数组，是数组
	# 	current_index = indexs.compact

	# 	# 上一题
	# 	if current_index[0] > min_index
	# 		pre_question_id = fav_question_ids[current_index[0] - 1]
	# 		@pre_question = Question.find(pre_question_id)
	# 	end

	# 	# 下一题
	# 	if current_index[0] < max_index
	# 		next_question_id = fav_question_ids[current_index[0] + 1]
	# 		@next_question = Question.find(next_question_id)
	# 	end

	# 	respond_to do |format|
	# 		format.html
	# 	end
	# end

	def error_answer
		@student = Student.find(session[:student_id])
		@current_question = Question.find(params[:question_id])

		@answer = Answer.find_by_student_id_and_question_id(@student.id, @current_question.id)

		@question_answer = Option.find_by_question_id_and_correct(@current_question.id, 't')
		
		@select_option = Option.find(params[:option_id])

		if @question_answer.id == @select_option.id
			@answer.correct = 1
			@answer.save
		end

		respond_to do |format|
			format.html { redirect_to show_error_answer_path(@current_question.id, @select_option.id) }
		end
	end

	def show_error_answer
		@student = Student.find(session[:student_id])
		@current_question = Question.find(params[:question_id])
		@options = @current_question.options
		@option_all_tags = ["A", "B", "C", "D", "E", "F"]

		@analyse = Analyse.find_by_question_id(@current_question.id)
		
		@select_option = Option.find(params[:option_id])

	end

end
