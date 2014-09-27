class GroupsController < ApplicationController
	# 教师登陆进去展示的课堂群组页面
	def index
		@teacher = Teacher.find(session[:teacher_id])
		@current_group = Group.find_by_course_id(session[:course_id])
		@course_groups = Group.where("teacher_id = ? AND kind = ?", session[:teacher_id], "course")
		@class_groups = Group.where("teacher_id = ? AND kind = ?", session[:teacher_id], "class")
	end
	# 学生登陆进去展示的课堂群组页面
	def student_groups
		@student = Student.find(session[:student_id])
		@current_group = Group.find_by_course_id(session[:course_id])
		group_ids = @student.group_ids
		group_ids.collect do |group_id|
			@course_groups = Group.where("id = ? AND kind = ?", group_id, "course")
			@class_groups = Group.where("id = ? AND kind = ?", group_id, "class")
		end
	end

	def show
		@group = Group.find(params[:id])
	end

	def edit
		@group = Group.find(params[:id])
	end

	def update
		@group = Group.find(params[:id])

		respond_to do |format|
			if @group.update_attributes(params[:group])
				format.html { redirect_to groups_path(@group), :notice => "success." }
			else
				format.html { render :action => "edit" }
			end
		end
	end

	def new
		@group = Group.new
	end

	def create
		@group = Group.new(params[:group])
		@teacher = Teacher.find(session[:teacher_id])
		@group.teacher = @teacher
		@group.kind = params[:kind]
		if params[:kind] == 'course'
			@course = Course.find_by_name(params[:group][:name])
			@group.course_id = @course.id
			@group.academy_id = @course.academy_id
		end
		

		respond_to do |format|
			if @group.save
				format.html { redirect_to groups_path, notice: "success" }
			else
				format.html { render action: "new" }
			end
		end
	end

	def add_members
		@group = Group.find(1)
		@teacher = Teacher.find(session[:teacher_id])
		@teacher_info = TeacherInfo.find_by_id(@teacher.id)
		@student_infos = StudentInfo.order
	end

	def add_members_finish
		@group = Group.find(1)
		@teacher = Teacher.find(session[:teacher_id])

		if params[:member_ids].nil?
			redirect_to add_members_groups_path(@group), notice: "no groupmember"
		else
			member_ids = params[:member_ids]

			member_ids.each do |member_id|
				@group_member = GroupMember.new
				@group_member.group = @group
				@group_member.student_id = member_id

				@students_teacher = StudentsTeacher.new
				@students_teacher.teacher_id = @teacher.id
				@students_teacher.student_id = member_id

				@group_member.save
				@students_teacher.save
			end
		end

		respond_to do |format|
			format.html { redirect_to groups_path, notice: "success!" }
		end
	end

end
