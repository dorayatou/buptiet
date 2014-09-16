class AnalysesController < ApplicationController
	include ApplicationHelper
	# before_filter :admin_protect, :only => [:new, :create, :destroy]
	# before_filter :teacher_protect, :only => [:index]
	# before_filter :student_protect, :except => [:index, :new, :create, :destroy]

	# 精细辨认是一门课程、里面有三个测试。其中图形操作课程、儿童入学成熟量表也是精细辨认课程里面的的测试
	def other_quiz_analyse
		@select_course = Course.find(params[:course_id])
		@select_quiz = Quiz.find(params[:quiz_id])
		# 精细辨认下的习题测试
		@finding_datas = FindingToneScore.all 
		@playing_dates = PlayingToneScore.all 
		@practice_datas = PracticeToneScore.all 
		@iqtests_dates = IqTest.all 
		@image_courses_dates = ImageCourse.all
		# 公开课下的测试
		@report_dates = Report.all
	end

	def index
		@current_course = Course.find(params[:course_id])
		@current_quiz = Quiz.find(params[:quiz_id])
		@questions = Question.where("quiz_id = ?", @current_quiz)
		if @questions.empty?
			@finding_datas = FindingToneScore.all 
			@playing_dates = PlayingToneScore.all 
			@practice_datas = PracticeToneScore.all 
			@iqtests_dates = IqTest.all 
			@image_courses_dates = ImageCourse.all 
		end
	end

	def new
		@current_course = Course.find(params[:course_id])
		@current_quiz = Quiz.find(params[:quiz_id])
		@question = Question.find(params[:question_id])
		@analyse = Analyse.new
	end

	def create
		@analyse = Analyse.new(params[:analyse])
		@current_course = Course.find(params[:course_id])
		@current_quiz = Quiz.find(params[:quiz_id])
		@question = Question.find(params[:question_id])
		@analyse.question_id = params[:question_id]

		respond_to do |format|
			if @analyse.save
				format.html { redirect_to course_quiz_question_path(@current_course, @current_quiz, @question), :notice => "success" }
			else
				format.html { render :action => "new"}
			end
		end
	end

	def destroy
		@current_course = Course.find(params[:course_id])
		@current_quiz = Quiz.find(params[:quiz_id])
		@question = Question.find(params[:question_id])
		@analyse = Analyse.find(params[:id])
		@analyse.destroy

		respond_to do |format|
			format.html { redirect_to course_quiz_question_path(@current_course, @current_quiz, @question) }
		end
	end

	def show_analyse
		@student = Student.find(session[:student_id])
		@exercise = Quiz.find(params[:exercise_id])
		@current_question = Question.find(params[:question_id])
		@options = @current_question.options

		@analyse = Analyse.find_by_question_id(@current_question.id)
		@option_all_tags = ["A", "B", "C", "D", "E", "F"]

		# 检查答案是否正确
		@check_answer = Answer.find_by_student_id_and_quiz_id_and_question_id(@student.id, @exercise.id, @current_question.id)
		
		# 检查该题目是否收藏
		# @check_fav = Favourite.find_by_question_id(@current_question.id)
		@check_fav = Answer.find_by_student_id_and_question_id_and_fav_flag(@student.id, @current_question.id, 't')

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

	def show_wrong_question_analyse
		@student = Student.find(session[:student_id])
		@exercise = Quiz.find(params[:exercise_id])
		@current_question = Question.find(params[:question_id])
		@options = @current_question.options

		@analyse = Analyse.find_by_question_id(@current_question.id)
		@option_all_tags = ["A", "B", "C", "D", "E", "F"]
		
		# 检查答案是否正确
		@check_answer = Answer.find_by_student_id_and_quiz_id_and_question_id(@student.id, @exercise.id, @current_question.id)

		# 检查该题目是否收藏
		# @check_fav = Favourite.find_by_question_id(@current_question.id)
		@check_fav = Answer.find_by_student_id_and_question_id_and_fav_flag(@student.id, @current_question.id, 't')

		# 错题的上下题设计
		wrong_answers_question_ids = Answer.order("question_id").where("student_id = ? AND quiz_id = ? and correct = ?", @student.id, @exercise.id, 'f').pluck(:question_id)
		@wrong_answers_questions = wrong_answers_question_ids.collect do |question_id|
			Question.find(question_id)
		end
		long = wrong_answers_question_ids.size
		min_index = 0
		max_index = long - 1
		current_question_id = @current_question.id
		indexs = (min_index..max_index).collect do |index|
			if wrong_answers_question_ids[index] == current_question_id
				current_index = index
			end
		end

		# 返回含有当前指针的数组，是数组
		current_index = indexs.compact

		# 上一题
		if current_index[0] > min_index
			pre_question_id = wrong_answers_question_ids[current_index[0] - 1]
			@pre_question = Question.find(pre_question_id)
		end

		# 下一题
		if current_index[0] < max_index
			next_question_id = wrong_answers_question_ids[current_index[0] + 1]
			@next_question = Question.find(next_question_id)
		end

		respond_to do |format|
			format.html
		end
	end

	# def admin_protect
	# 	if session[:admin_id].nil?
	# 		redirect_to buptiet_url, :alter => "Login!"
	# 		return false
	# 	end
	# end

	# def teacher_protect
	# 	if session[:teacher_id].nil?
	# 		redirect_to buptiet_url, :alter => "Login!"
	# 		return false
	# 	end
	# end

	# def student_protect
	# 	if session[:student_id].nil?
	# 		redirect_to buptiet_url, :alter => "Login!"
	# 		return false
	# 	end
	# end

end