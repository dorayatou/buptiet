class ProblemsController < ApplicationController
	# 学生登陆进去的问题墙
	def index_student
		@student_problems = Problem.order("created_at DESC").where("student_id").limit(3)
	end
	# 教师登陆进去的问题墙
	def index_teacher
		@teacher = Teacher.find(session[:teacher_id])
		@current_course = Course.find(session[:course_id])
		@student_problems = Problem.order("created_at DESC").where("student_id").limit(3)
	end

	#我也要问，赞数加1
	def problem_zan
		problem = Problem.find(params[:problem_id])
		problem.number += 1
		problem.save
    @student_lists = AnswerStudentList.student_lists(problem.id)
		
		respond_to do |format|
			format.html { redirect_to index_student_problems_path }
		end
	end

	# 新建一个问题
	def new
		@problem = Problem.new
	end
	# 与new一起新建问题
	def create
		@problem = Problem.new(params[:problem])
    @problem.number = 0

		if session[:student_id]
			@problem.student_id = session[:student_id]
		elsif session[:teacher_id]
			@problem.teacher_id = session[:teacher_id]
		end

		respond_to do |format|
			if @problem.save
				if not session[:student_id].nil?
					format.html { redirect_to index_student_problems_path, :notice => "success!" }
				elsif not session[:teacher_id].nil?
					format.html { redirect_to index_teacher_problems_path, :notice => "success!" }
				end
			else
				format.html { render :action => "new" }
			end
		end
	end

end
