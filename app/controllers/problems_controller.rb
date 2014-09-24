class ProblemsController < ApplicationController
	# 学生登陆进去的问题墙
	def index_student
		@problems = Problem.order("updated_at DESC")
	end
	# 教师登陆进去的问题墙
	def index_teacher
		@teacher = Teacher.find(session[:teacher_id])
		@current_course = Course.find(session[:course_id])
		@problems = Problem.order("updated_at DESC").limit(5)
	end

	#我也要问，赞数加1
	def problem_zan
		problem = Problem.find(params[:problem_id])
		@problem_student = ProblemStudent.create(:problem_id => problem.id, :student_id => current_student.id)
		problem.number += 1
		problem.save
    @student_lists = AnswerStudentList.student_lists(problem.id)
		
		respond_to do |format|
			format.html { redirect_to index_student_problems_path }
		end
	end

	def destroy
		@problem = Problem.find(params[:problem_id])
		@problem_students = ProblemStudent.where('problem_id = ?', params[:problem_id])
		@problem_students.each do |pt|
			pt.delete
		end
		@problem.destroy

		respond_to do |format|
			format.html { redirect_to index_teacher_problems_path }
		end
	end
	# 新建一个问题
	def new
		@problem = Problem.new
	end
	# 与new一起新建问题
	def create
		@problem = Problem.new(params[:problem])
		@problem.student_id = session[:student_id]
    @problem.number = 1
    @problem.course_id = session[:course_id]
		
		respond_to do |format|
			if @problem.save
				ProblemStudent.create(:problem_id => @problem.id, :student_id => session[:student_id])
				format.html { redirect_to index_student_problems_path, :notice => "success!" }
			else
				format.html { render :action => "new" }
			end
		end
	end

end
