class StudentsController < ApplicationController
    # 精细辨认应用——请求个人信息
    def get_student_info
        @student = current_student
			  @student_info = @student.student_info
        render template: "students/get_student_info.json.rabl"
    end

    def index
        @student = current_student
			  @student_info = @student.student_info
        @posts = Post.order("created_at DESC").limit(5)
        @course_lists = @student.courses
        course_ids = @student.course_ids
				session[:course_id] = CourseTime.current_course_id(course_ids)
    		@course = current_course
    end

    def show
        @student = current_student
			  @student_info = @student.student_info
        @posts = Post.order("created_at DESC").limit(5)
        academy_id = @student_info.academy_id
        @academy ||= Academy.find(academy_id)
    end

    def edit
        @student = current_student
			  @student_info = @student.student_info
    end

    def update
        @student = current_student

        respond_to do |format|
            if @student.update_attributes(params[:student])
                format.html { redirect_to @student, :notice => "success" } 
            else
                format.html { render :action => "edit"}
            end
        end
    end
    

    def new
        @student = Student.new
    end

    def create
        @student = Student.new(params[:student])
        @student_info = StudentInfo.new
        @student_info.student = @student

        respond_to do |format|
            if @student.save and @student_info.save
                format.html {  redirect_to show_all_students_admins_path,  :notice => "success" }
            else
                format.html { render action: "new" }    
            end
        end
    end
    # 学生添加与移除群组模块
    def groups
        @student = current_student
        @groups = @student.groups
    end

    def group_add
        @student = current_student
        @group = Group.find(params[:group])
        @student.groups << @group
    end
    # 学生选课与退课模块
    def courses
        @student = current_student
        @courses = @student.courses
    end

    def course_add
        @student = current_student
        @course = Course.find(params[:course])
        @student.courses << @course
    end

    def course_remove
        @student = current_student
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
