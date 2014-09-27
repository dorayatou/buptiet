class StudentInfosController < ApplicationController
	def new
		@student_info = StudentInfo.new
	end

	def edit
		@student_info = StudentInfo.find(params[:id])
		@student = @student_info.student
	end

	def update
    	@student_info = StudentInfo.find(params[:id])
    	@student = @student_info.student
    	@student_info.academy_id = params[:academy_id]

    	respond_to do |format|
    		if @student_info.update_attributes(params[:student_info])
    			format.html { redirect_to @student } 
        	else
          		format.html { render :action => "edit" }
        	end
    	end
 	 end

end
