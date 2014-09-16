class AdminsController < ApplicationController
	include ApplicationHelper
	# before_filter :admin_protect
	
	def index
		@admin = Admin.find(session[:admin_id])
	end

	def show
		@courses = Course.order(:identifier)
	end

	def show_all_admins
		@admin = Admin.find(session[:admin_id])
    	@admins = Admin.order(:identifier)
	end

	def show_all_users
		@admin = Admin.find(session[:admin_id])
		@teachers = Teacher.order(:identifier)
		@students = Student.order(:identifier)
	end

	def show_all_courses
		@admin = Admin.find(session[:admin_id])
		@courses = Course.order(:identifier)
	end

	def show_all_quizzes
		@admin = Admin.find(session[:admin_id])
		@courses = Course.order(:identifier)
	end

	def show_course_times
		@admin = Admin.find(session[:admin_id])
		@courses = Course.order(:identifier)
	end

	def show_previews
		@admin = Admin.find(session[:admin_id])
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

	def admin_protect
		if session[:admin_id].nil?
			redirect_to buptiet_url, :alter => "Login!"
			return false
		end
	end

end
