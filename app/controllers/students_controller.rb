class StudentsController < ApplicationController
    include ApplicationHelper
    # 精细辨认应用——请求个人信息
    def get_student_info
        @student = Student.find(session[:student_id])
        @student_info = StudentInfo.find_by_student_id(@student.id)
        render template: "students/get_student_info.json.rabl"
    end

    # 课堂交互工具应用方法
    # before_filter :student_protect
    # 学生权限

    def index
        @student = Student.find(session[:student_id])
        @student_info = StudentInfo.find_by_student_id(session[:student_id])
        @posts = Post.order("created_at DESC").limit(5)
        @course_lists = @student.courses
        courses = @student.courses
        course_ids = @student.course_ids
        # 学生目前的课程
        time = Time.now
        weekday = time.wday 
        period = time_to_period(time)
        # 返回得是一个数组对象
        course_ids.each do |course_id|
            @course_time = CourseTime.where("weekday = ? AND period = ? AND course_id = ?", weekday.to_s, period.to_s, course_id)
            if not @course_time.empty?
               session[:course_id] = course_id.to_s
            end
        end

        if not session[:course_id].nil?
            @course = Course.find(session[:course_id])
        else
            @course = nil
        end

    end

    def show
        @student = Student.find(session[:student_id])
        @student_info = StudentInfo.find_by_student_id(@student.id)
        academy_id = @student_info.academy_id
        if academy_id.nil?
            @academy = nil
        else
            @academy = Academy.find(academy_id)
        end
    end

    def edit
        @student = Student.find(session[:student_id])
        @student_info = StudentInfo.find_by_student_id(@student.id)
    end

    def update
        @student = Student.find(session[:student_id])

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
        @student = Student.find(session[:student_id])
        @groups = @student.groups
    end

    def group_add
        @student = Student.find(session[:student_id])
        @group = Group.find(params[:group])
        @student.groups << @group
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

    # def student_protect
    #     if session[:student_id].nil?
    #         redirect_to buptiet_url, :notice => "Login"
    #         return false
    #     end
    # end
end
