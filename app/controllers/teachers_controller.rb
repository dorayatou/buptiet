class TeachersController < ApplicationController
	before_filter :teacher_login, only: :index
	def index
		@teacher = current_teacher
		@teacher_info = @teacher.teacher_info
		@posts = Post.order("created_at DESC").limit(5)
		course_ids = @teacher.course_ids
		session[:course_id] = CourseTime.current_course_id(course_ids)
		@course = current_course	
	end

	# 教师与学生的关系
	def students
		@teacher = current_teacher
		@students = @teacher.students
	end

	def student_add
		@teacher = current_teacher
		@student = Student.find(params[:student])
		@teacher.students << @student
	end

	# 教师与课程的关系
	def courses
		@teacher = current_teacher
		@courses = @teacher.courses
	end


	def show
		@teacher = current_teacher
		@courses = @teacher.courses
		@teacher_info = @teacher.teacher_info 
		academy_id = @teacher_info.academy_id
		@academy ||= Academy.find(academy_id)
	end

	def new
		@teacher = Teacher.new
	end

	def create
		@teacher = Teacher.new(params[:teacher])
		@teacher_info = TeacherInfo.new
		@teacher_info.teacher = @teacher

		respond_to do |format|
			if @teacher.save and @teacher_info.save
				format.html {  redirect_to show_all_teachers_admins_path,  :notice => "success" }
			else
				format.html { render action: "new" }
			end
		end
	end

	def edit
		@teacher = current_teacher
		@teacher_info = @teacher.teacher_info 
	end

	def update
		@teacher = current_teacher
		respond_to do |format|
			if @teacher.update_attributes(params[:teacher])
				format.html { redirect_to @teacher, :notice => "success." } 
			else
				format.html { render :action => "edit"}
			end
		end
	end

	def destroy
    	@teacher = Teacher.find(params[:id])
   		@teacher.destroy

    	respond_to do |format|
      	format.html { redirect_to show_all_teachers_admins_path }
    	end
  	end

end
