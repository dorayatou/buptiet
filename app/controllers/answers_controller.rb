class AnswersController < ApplicationController
	# before_filter :student_protect

	def index
		@student = Student.find(session[:student_id])
		@exercise = Quiz.find(params[:exercise_id])
		@questions = @exercise.questions
		@question = @questions.first

		# 判断答案是否正确
		@answers = Answer.order("id").where("student_id = ? AND quiz_id = ?", @student.id, @exercise.id)
		@correct_answers = Answer.order("id").where("student_id = ? AND quiz_id = ? and correct = ?", @student.id, @exercise.id, 't')
		
		# 错题分析第一题
		wrong_answers_question_ids = Answer.order("question_id").where("student_id = ? AND quiz_id = ? and correct = ?", @student.id, @exercise.id, 'f').pluck(:question_id)
		if wrong_answers_question_ids.size == 0
			@wrong_question = nil
			@notice = "no error questions"
		else
			@wrong_question = Question.find(wrong_answers_question_ids[0])
		end
		
		
		# 测试时间设计

    	first_answer = @answers.first
    	first_answer_time = first_answer.created_at.to_a
    	first_answer_time_min = first_answer_time[1]
    	first_answer_time_hour = first_answer_time[2]
    	last_answer = @answers.last 
    	last_answer_time = last_answer.created_at.to_a
    	last_answer_time_min = last_answer_time[1]
    	last_answer_time_hour = last_answer_time[2]

    	if last_answer_time_hour == first_answer_time_hour
    		@test_time = last_answer_time_min - first_answer_time_min + 1
    	elsif last_answer_time_hour == first_answer_time_hour + 1
    		@test_time = last_answer_time_min - first_answer_time_min + 60
    	end

	end

	def answer_results
		@student = Student.find(session[:student_id])
		@exercise = Quiz.find(params[:exercise_id])
		@questions = @exercise.questions
		@question = @questions.first

		# 判断答案是否正确
		@answers = Answer.order("id").where("student_id = ? AND quiz_id = ?", @student.id, @exercise.id)
		@correct_answers = Answer.order("id").where("student_id = ? AND quiz_id = ? and correct = ?", @student.id, @exercise.id, 1)
		
		# 错题分析第一题
		wrong_answers_question_ids = Answer.order("question_id").where("student_id = ? AND quiz_id = ? and correct = ?", @student.id, @exercise.id, 'f').pluck(:question_id)
		if wrong_answers_question_ids.size == 0
			@wrong_question = nil
			@notice = "no error questions"
		else
			@wrong_question = Question.find(wrong_answers_question_ids[0])
		end
		
		
		# 测试时间设计

    	first_answer = @answers.first
    	first_answer_time = first_answer.created_at.to_a
    	first_answer_time_min = first_answer_time[1]
    	first_answer_time_hour = first_answer_time[2]
    	last_answer = @answers.last 
    	last_answer_time = last_answer.created_at.to_a
    	last_answer_time_min = last_answer_time[1]
    	last_answer_time_hour = last_answer_time[2]

    	if last_answer_time_hour == first_answer_time_hour
    		@test_time = last_answer_time_min - first_answer_time_min + 1
    	elsif last_answer_time_hour == first_answer_time_hour + 1
    		@test_time = last_answer_time_min - first_answer_time_min + 60
    	end

	end

	def show_answer
		@student = Student.find(session[:student_id])
		@exercise = Quiz.find(params[:exercise_id])
		@current_question = Question.find(params[:question_id])
		@options = @current_question.options
		@option_all_tags = ["A", "B", "C", "D", "E", "F"]

		# @check_answer = Answer.where("student_id = ? AND quiz_id = ? AND question_id = ?", @student.id, @exercise.id, @current_question.id)
		@check_answer = Answer.find_by_student_id_and_quiz_id_and_question_id(@student.id, @exercise.id, @current_question.id)

		# @analyse = Analyse.find_by_question_id(@current_question.id)
		
	
		# 上下题设计
		@questions = @exercise.questions
		@first_question = @questions.first
		first_question_id = @first_question.id
		@last_question = @questions.last
		last_question_id = @last_question.id
		current_question_id = @current_question.id

		# 上一题
		if current_question_id > first_question_id
			pre_question_id = current_question_id - 1
			@pre_question = Question.find(pre_question_id)
		end
		# 下一题
		if current_question_id < last_question_id
			next_question_id = current_question_id + 1
			@next_question = Question.find(next_question_id)
		end

		respond_to do |format|
			format.html
		end
	end



	def answer_question
		@student = Student.find(session[:student_id])
		@exercise = Quiz.find(params[:exercise_id])
		@current_question = Question.find(params[:question_id])

		questions = @exercise.questions
		last_question = questions.last
		last_question_id = last_question.id

		first_question = questions.first
		first_question_id = first_question.id

		current_question_id = @current_question.id

		if current_question_id < last_question_id
			next_question_id = current_question_id + 1
			@next_question = Question.find(next_question_id)
		end

		if current_question_id > first_question_id
			pre_question_id = current_question_id - 1
			@pre_question = Question.find(pre_question_id)
		end


		# 遍历answers查看该题是否已做过，如果做过了，则删除原来答案
		
		# answers = Answer.where("question_id = ?", @question.id)
		# if answers
		# 	answers.each do |answer|
		# 		answer.delete
		# 	end
		# end

			@select_option = Option.find(params[:option_id])

			answer_flag = 0
			if @select_option
				@answer = Answer.new(:student_id => @student.id, :quiz_id => @exercise.id, :question_id => @current_question.id, :option_id => @select_option.id, :fav_flag => 'f')
				answer_flag = 1
			# else
			# 	answer_flag = 0
			end

			question_answer_id = Option.where("question_id = ? AND correct = ?", @current_question.id, 't').pluck(:id)
			if question_answer_id[0] == @answer.option_id
				@answer.correct = 't'
			else
				@answer.correct = 'f'
			end

			total_num = @current_question.total_num
			correct_num = @current_question.correct_num
			# @option = Option.find(params[:option_id])
			select_num = @select_option.select_num

			respond_to do |format|
				if answer_flag == 1
					if @answer.save
						total_num = total_num + 1
						select_num = select_num + 1
						if @answer.correct
							correct_num = correct_num + 1
							if @current_question.update_attributes(:total_num => total_num, :correct_num => correct_num) and @select_option.update_attributes(:select_num => select_num)
								if @next_question
					  				format.html { redirect_to show_question_answer_path(@exercise, @next_question) }
					  		 	else
					  		 		format.html { redirect_to show_question_answer_path(@exercise, @current_question) }
					  		 	end
					  		end
					  	else
					  		if @current_question.update_attributes(:total_num => total_num) and @select_option.update_attributes(:select_num => select_num)
					   			format.html { redirect_to show_question_answer_path(@exercise, @next_question) }
					   		end
						end
					else
						format.html { redirect_to show_question_answer_path(@exercise, @current_question), :notice => "answer fail" }
					end
				elsif answer_flag == 0
					format.html { redirect_to show_question_answer_path(@exercise, @current_question), :notice => "select answer" }
				end
			end
		# end
	end

	def student_protect
		if session[:student_id].nil?
			redirect_to buptiet_path, :alter => "login!"
			return false
		end
	end

end
