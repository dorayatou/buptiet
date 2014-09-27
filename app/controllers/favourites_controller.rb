class FavouritesController < ApplicationController
	# 收藏库首页
	def index
		@student = Student.find(session[:student_id])
		fav_question_ids = Answer.order(:question_id).where("student_id = ? AND fav_flag = ?", @student.id, 't').pluck(:question_id)
		@fav_question_number = fav_question_ids.size
		if @fav_question_number == 0
			@question = nil
		else
			@question = Question.find(fav_question_ids[0])
		end
	end
	# 展示收藏库中的题目，包括重做功能
	def show
		@student = Student.find(session[:student_id])
		@current_question = Question.find(params[:question_id])
		@options = @current_question.options
		@option_all_tags = ["A", "B", "C", "D", "E", "F"]

		@analyse = Analyse.find_by_question_id(@current_question.id)

		fav_question_ids = Answer.order(:question_id).where("student_id = ? AND fav_flag = ?", @student.id, 't').pluck(:question_id)

		current_question_id = @current_question.id

		long = fav_question_ids.size
		min_index = 0
		max_index = long - 1
		
		indexs = (min_index..max_index).collect do |index|
			if fav_question_ids[index] == current_question_id
				current_index = index
			end
		end

		# 返回含有当前指针的数组，是数组
		current_index = indexs.compact

		# 上一题
		if current_index[0] > min_index
			pre_question_id = fav_question_ids[current_index[0] - 1]
			@pre_question = Question.find(pre_question_id)
		end

		# 下一题
		if current_index[0] < max_index
			next_question_id = fav_question_ids[current_index[0] + 1]
			@next_question = Question.find(next_question_id)
		end

		respond_to do |format|
			format.html
		end
	end
	# 收藏动作
	def fav_question
		
		@student = Student.find(session[:student_id])
		@exercise = Quiz.find(params[:exercise_id])
		@question = Question.find(params[:question_id])
		
		@answer = Answer.find_by_student_id_and_question_id(@student.id, @question.id)
		@answer.fav_flag = 't'
		@answer.save

		respond_to do |format|
			format.html { redirect_to show_analyse_path(@exercise.id, @question.id), :notice => 'success' }
		end
	end
	# 取消收藏
	def destroy_fav_question
		@student = Student.find(session[:student_id])
		@exercise = Quiz.find(params[:exercise_id])
		@question = Question.find(params[:question_id])

		@answer = Answer.find_by_student_id_and_question_id(@student.id, @question.id)
		@answer.fav_flag = 'f'
		@answer.save

		respond_to do |format|
			format.html { redirect_to show_analyse_path(@exercise.id, @question.id), :notice => 'success' }
		end
	end

	def fav_wrong_question
		@student = Student.find(session[:student_id])
		@exercise = Quiz.find(params[:exercise_id])
		@question = Question.find(params[:question_id])

		@answer = Answer.find_by_student_id_and_question_id(@student.id, @question.id)
		@answer.fav_flag = 't'
		@answer.save

		respond_to do |format|
			format.html { redirect_to show_wrong_question_analyse_path(@exercise.id, @question.id), :notice => 'success' }
		end
	end

	def destroy_fav_wrong_question
		@student = Student.find(session[:student_id])
		@exercise = Quiz.find(params[:exercise_id])
		@question = Question.find(params[:question_id])

		@answer = Answer.find_by_student_id_and_question_id(@student.id, @question.id)
		@answer.fav_flag = 'f'
		@answer.save

		respond_to do |format|
			format.html { redirect_to show_wrong_question_analyse_path(@exercise.id, @question.id), :notice => 'success' }
		end
	end
	# 收藏库中的题目重新做
	def show_fav
		@student = Student.find(session[:student_id])
		@current_question = Question.find(params[:question_id])
		@options = @current_question.options
		@option_all_tags = ["A", "B", "C", "D", "E", "F"]

		@analyse = Analyse.find_by_question_id(@current_question.id)

		# @question_answer = Option.find_by_question_id_and_correct(@current_question.id, 't')

		if params[:option_id]
			@select_option = Option.find(params[:option_id])
		else
			@select_option = nil
		end

		@check_fav = Answer.find_by_student_id_and_question_id_and_fav_flag(@student.id, @current_question.id, 't')

		# 收藏库题目设计
		fav_question_ids = Answer.order(:question_id).where("student_id = ? AND fav_flag = ?", @student.id, 't').pluck(:question_id)

		current_question_id = @current_question.id

		long = fav_question_ids.size
		min_index = 0
		max_index = long - 1
		
		indexs = (min_index..max_index).collect do |index|
			if fav_question_ids[index] == current_question_id
				current_index = index
			end
		end

		# 返回含有当前指针的数组，是数组
		current_index = indexs.compact

		# 上一题
		if current_index[0] > min_index
			pre_question_id = fav_question_ids[current_index[0] - 1]
			@pre_question = Question.find(pre_question_id)
		end

		# 下一题
		if current_index[0] < max_index
			next_question_id = fav_question_ids[current_index[0] + 1]
			@next_question = Question.find(next_question_id)
		end

		respond_to do |format|
			format.html
		end
	end

	def destroy_fav
		@student = Student.find(session[:student_id])
		@current_question = Question.find(params[:question_id])
		@answer = Answer.find_by_student_id_and_question_id(@student.id, @current_question.id)

		@select_option = Option.find(params[:option_id])

		@answer.fav_flag = 'f'
		@answer.save
		
		respond_to do |format|
			format.html { redirect_to show_fav_answer_path(@current_question.id, @select_option.id) }
		end
	end

	def show_fav_answer
		@student = Student.find(session[:student_id])
		@current_question = Question.find(params[:question_id])
		@options = @current_question.options
		@option_all_tags = ["A", "B", "C", "D", "E", "F"]

		@analyse = Analyse.find_by_question_id(@current_question.id)

		@select_option = Option.find(params[:option_id])
		# 注意程序是顺序执行的
		@fav = Answer.find_by_student_id_and_question_id_and_fav_flag(@student.id, @current_question.id, 't')
		@answer = Answer.find_by_student_id_and_question_id(@student.id, @current_question.id)
		if @fav
			@answer.fav_flag = 'f'
			@answer.save
		else
			@answer.fav_flag = 't'
			@answer.save
		end

		@fav = Answer.find_by_student_id_and_question_id_and_fav_flag(@student.id, @current_question.id, 't')
		
		respond_to do |format|
			format.html
		end
	end

end
