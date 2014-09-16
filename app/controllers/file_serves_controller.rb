class FileServesController < ApplicationController
	def index
		@course = Course.find(session[:course_id])
		@searchs = FileServe.find_all_by_course_id(@course.id)
	end
end