class CourseTimesController < ApplicationController
	def index
		@course = Course.find(params[:course_id])
		@course_times = CourseTime.find_all_by_course_id(@course.id)
	end

	def show
		@course = Course.find(params[:course_id])
	end

	def new
		@course = Course.find(params[:course_id])
		@course_time = CourseTime.new
	end

	def create
		@course = Course.find(params[:course_id])
		@course_time = CourseTime.new(params[:course_time])
		@course_time.course_id = @course.id

		respond_to do |format|
      		if @course_time.save
        		format.html { redirect_to course_course_times_path(@course.id), notice: 'success' }
      		else
        		format.html { render action: "new" }
      		end
    	end
	end

	def edit
		
	end
end
