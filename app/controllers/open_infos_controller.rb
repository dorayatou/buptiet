class OpenInfosController < ApplicationController
	# 开放用户信息
	def open_students_info
		@student_infos = StudentInfo.all

		respond_to do |format|
			format.xml { render :xml => @student_infos }
		end
	end
	# 开放学生选课信息
	def open_student_select_course_info
		@student = Student.find(1) 
		@select_courses = @student.courses

		# @students.each do |student|
		# 	@select_courses = student.courses
		# end

		respond_to do |format|
			format.xml { render :xml => @select_courses }
		end
	end

	# 开放学生投票信息
	def open_votes
		# @student = Student.find(1)
		@topic = Topic.find(1)
		@votes = @topic.opinions

		respond_to do |format|
			format.xml { render :xml => @votes }
		end
	end

	# 开放学生练习信息
	def open_exercises
		@quizzes = Quiz.all 

		respond_to do |format|
			format.xml { render :xml => @quizzes }
		end
	end

end
