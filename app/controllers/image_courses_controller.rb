class ImageCoursesController < ApplicationController
	def create
		@data = params[:contents]
        a1 = Array.new
        a1 = ActiveSupport::JSON.decode(@data)
        a1.each do |a|
        	@new_record = ImageCourse.new(:question_num => a["question_num"], :question_item => a["question_item"], :score_item => a["score_item"], :score => a["score"])
            @new_record.save
        end
        render(:text => "success")
	end
end
