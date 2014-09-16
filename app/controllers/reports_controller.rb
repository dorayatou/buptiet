class ReportsController < ApplicationController
	def index
		@reports_data = Report.all
	end

	def create
		@student = Student.find(session[:student_id])
		# @student_info = StudentInfo.find_by_student_id(@student.id)
		@data = params[:DataBaseContent]
        a1 = Array.new
        a1 = ActiveSupport::JSON.decode(@data)
        a1.each do |a|
        	@new_record = Report.new(:course_name => a["course_name"], :learning_time => a["learning_time"])
            @new_record.student_id = @student.id
            @new_record.save
        end
        render(:text => "success")
	end
end