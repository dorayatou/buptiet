class SelectsController < ApplicationController
	def index
		@courses = Course.order(:identifier).all
	end

	def show
		@course = Course.find(params[:course_id])

		all_students = Student.all 
		selected_students = @course.students
        @students = all_students - selected_students
	end

    def student_list
        @course = Course.find(params[:course_id])
        @students = @course.students
    end

	def student_add
		@course = Course.find(params[:course_id])
        select_student_ids = params[:student_ids]
       
		select_student_ids.each do |select_student_id|
			@student = Student.find(select_student_id)
            @course.students << @student
        end

        respond_to do |format|
        	format.html {  redirect_to student_list_path, :notice => "success" }
        end
	end

	# 学生选课与退课模块
    def courses
        @student = Student.find(session[:student_id])
        @courses = @student.courses
    end

    def course_add
        @student = Student.find(session[:student_id])
        @course = Course.find(params[:course])
        @student.courses << @course
    end

    def course_remove
        @student = Student.find(session[:student_id])
        @courses = @student.courses
        course_ids = @courses.collect do |course|
            course.id
        end

        unless course_ids.blank?
            course_ids.each do |course_id|
                course = Course.find(course_id)
                @student.courses.delete(course)
                flash[:notice] = 'success'
                
            end
        end
        redirect_to :action => :student_courses, :id => @student
    end

end