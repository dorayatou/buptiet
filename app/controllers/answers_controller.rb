class AnswersController < ApplicationController
	def index
		@student = current_student
		@exercise = Quiz.find(params[:exercise_id])
		question_ids = Question.question_list(params[:exercise_id])
		@question = Question.find(question_ids[0])
		@answers = Answer.number(@student.id, params[:exercise_id])
		@correct_num = Answer.correct_num(@student.id, params[:exercise_id])
		wrong_answers_question_ids = Answer.wrong_question_list(@student.id, params[:exercise_id])
		@wrong_question_id ||= wrong_answers_question_ids[0]
		@test_time = 12	
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

		@check_answer = Answer.find_by_student_id_and_question_id(@student.id, @current_question.id)

		@pre_question_id = @current_question.pre_question_id
    @next_question_id = @current_question.next_question_id
		
		respond_to do |format|
			format.html
		end
	end

	def answer_question
		@student = Student.find(session[:student_id])
		@exercise = Quiz.find(params[:exercise_id])
		@current_question = Question.find(params[:question_id])

		@next_question_id = @current_question.next_question_id

		questions = @exercise.questions

		@select_option = Option.find(params[:option_id])

			answer_flag = 0
			if @select_option
				@answer = Answer.create(:student_id => @student.id, :quiz_id => @exercise.id, :question_id => @current_question.id, :option_id => @select_option.id, :fav_flag => 'f')
				@current_question.total_num_plus
				@select_option.select_num_plus
				answer_flag = 1
			end

			correct = @current_question.correct
			if correct == @answer.option_id
				@answer.correct = 't'
			else
				@answer.correct = 'f'
			end

			respond_to do |format|
				if answer_flag == 1
						if @answer.correct?
							@current_question.correct_num_plus
						end
						format.html { redirect_to show_question_answer_path(@exercise, @current_question.id), :notice => "answer fail" }
				end
			end
	end

end
