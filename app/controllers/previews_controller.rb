class PreviewsController < ApplicationController
	def index
		@course = Course.find(params[:course_id])
		@previews = Preview.where('course_id = ?', @course.id) 
	end

	def show
		@course = Course.find(params[:course_id])
		@preview = Preview.find(params[:id])
	end

	def student_previews
		@current_course = Course.find(params[:course_id])
		@previews = Preview.where('course_id = ?', @current_course.id)
	end

	def teacher_previews
		@teacher = current_teacher
		@current_course = Course.find(params[:course_id])
		@previews = Preview.where('course_id = ?', @current_course.id)
	end

	def edit
		@course = Course.find(params[:course_id])
		@preview = Preview.find(params[:id])
	end

	def update
		@course = Course.find(params[:course_id])
		@preview = Preview.find(params[:id])
		@preview.body = params[:preview][:body]
		@preview.save

		redirect_to course_previews_path(@course.id) 
	end

	def destroy
		@course = Course.find(params[:course_id])
		@preview = Preview.find(params[:id])
		@preview.delete
		 
		respond_to do |format|
			format.html { redirect_to course_previews_path(@course.id) }
		end
	end

	def new
		@course = Course.find(params[:course_id])
		@preview = Preview.new
	end

	def create
		@preview = Preview.new(params[:preview])
		@course = Course.find(params[:course_id])
		@preview.course_id = @course.id

		respond_to do |format|
      if @preview.save
        format.html { redirect_to course_previews_path(@course.id), notice: 'success' }
    	else
      	format.html { render action: "new" }
    	end
    end
	end

end
