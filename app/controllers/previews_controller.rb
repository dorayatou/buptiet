class PreviewsController < ApplicationController
	def index
		@course = Course.find(params[:course_id])
		@previews = Preview.where('course_id = ?', @course.id) 
	end

	def student_previews
		@course = Course.find(params[:course_id])
		@previews = Preview.where('course_id = ?', @course.id)
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
