class MessagesController < ApplicationController
	def show_message
        @post = Post.find(params[:id])
        @comments = Comment.where("post_id = ?", @post.id)
        if session[:teacher_id]
            @student_info = StudentInfo.find_by_student_id(@post.student_id)
        elsif session[:student_id]
            @teacher_info = TeacherInfo.find_by_teacher_id(@post.teacher_id)
        end
    end

    def teacher_all_post_messages
		@student = Student.find(session[:student_id])
        @student_info = StudentInfo.find_by_student_id(session[:student_id])
        # @teachers = @student.teachers
        # teacher_ids = @student.teacher_ids
        @teacher_posts = Post.order("created_at DESC").where("teacher_id")
        courses = @student.courses
        course_ids = @student.course_ids
        # 学生目前的课程
        time = Time.now
        weekday = time.wday 
        period = time_to_period(time)
        # 返回得是一个数组对象
        course_ids.each do |course_id|
            @course_time = CourseTime.where("weekday = ? AND period = ? AND course_id = ?", weekday, period, course_id)
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

	def student_all_post_messages
		@teacher = Teacher.find(session[:teacher_id])
		@teacher_info = TeacherInfo.find_by_id(@teacher.id)
		# @students = @teacher.students
		@student_posts = Post.order("created_at DESC").where("student_id")
		courses = @teacher.courses
		course_ids = @teacher.course_ids
		session[:course_id] = CourseTime.current_course_id(course_ids)
		@course = current_course
	end
	
end
