class AdminsController < ApplicationController
	def index
	  @admin = current_admin
	end

	def show
		@courses = Course.order(:identifier)
	end

	def show_all_admins
	  @admin = current_admin
    @admins = Admin.order(:identifier)
	end

	def show_all_users
	  @admin = current_admin
		@teachers = Teacher.order(:identifier)
		@students = Student.order(:identifier)
	end

	def show_all_courses
	  @admin = current_admin
		@teachers = Teacher.order(:identifier)
		@courses = Course.order(:identifier)
	end

	def show_all_quizzes
		@admin = current_admin 
		@courses = Course.order(:identifier)
	end

	def show_course_times
		@admin = current_admin 
		@courses = Course.order(:identifier)
	end

	def show_previews
		@admin = current_admin 
		@courses = Course.order(:identifier)
	end

	def new
		@admin = Admin.new
	end

	def create
		@admin = Admin.new(params[:admin])
		@admin_info = AdminInfo.new
		@admin_info.admin_id = @admin.id

		respond_to do |format|
			if @admin.save and @admin_info.save
				format.html { redirect_to show_all_admins_admins_path, :notice => "A new admin was successfully created." }
			else
				format.html { render action: "new"}
			end
		end
	end

end
