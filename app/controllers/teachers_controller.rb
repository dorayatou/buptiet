class TeachersController < ApplicationController
	include ApplicationHelper
	# before_filter :teacher_protect
	
	def index
		@teacher = Teacher.find(session[:teacher_id])
		@teacher_info = TeacherInfo.find_by_id(@teacher.id)
		# @students = @teacher.students
		@posts = Post.order("created_at DESC").limit(5)
		courses = @teacher.courses
		course_ids = @teacher.course_ids
		
		# 当前时间
		time = Time.now
        weekday = time.wday
        period = time_to_period(time)

        course_ids.each do |course_id|
            @course_time = CourseTime.where("weekday = ? AND period = ? AND course_id = ?", weekday.to_s, period.to_s, course_id)
            if not @course_time.empty?
               session[:course_id] = course_id
            end
        end

        if not session[:course_id].nil?
            @course = Course.find(session[:course_id])
            # session[:course] = @course
        else
            @course = nil
        end

	end

	# 教师与学生的关系
	def students
		@teacher = Teacher.find(session[:teacher_id])
		@students = @teacher.students
	end

	def student_add
		@teacher = Teacher.find(session[:teacher_id])
		@student = Student.find(params[:student])
		@teacher.students << @student
	end

	# 教师与课程的关系
	def courses
		@teacher = Teacher.find(session[:teacher_id])
		@courses = @teacher.courses
	end


	def show
		@teacher = Teacher.find(session[:teacher_id])
		@teacher_info = TeacherInfo.find_by_teacher_id(@teacher.id)
		academy_id = @teacher_info.academy_id
		if academy_id.nil?
			@academy = nil
		else
			@academy = Academy.find(academy_id)
		end
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
		@teacher = Teacher.find(session[:teacher_id])
		@teacher_info = TeacherInfo.find_by_teacher_id(@teacher.id)
	end

	def update
		@teacher = Teacher.find(session[:teacher_id])

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

  	def teacher_protect
		if session[:teacher_id].nil?
			redirect_to buptiet_url, :notice => "Login"
			return false
		end
	end

end
