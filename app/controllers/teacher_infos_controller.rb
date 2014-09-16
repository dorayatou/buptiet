class TeacherInfosController < ApplicationController
    # before_filter :teacher_protect

	def new
		@teacher_info = TeacherInfo.new
	end

	def edit
		@teacher_info = TeacherInfo.find(params[:id])
		@teacher = @teacher_info.teacher
	end

	def update
    	@teacher_info = TeacherInfo.find(params[:id])
    	@teacher = @teacher_info.teacher
    	@teacher_info.academy_id = params[:academy_id]

    	respond_to do |format|
    		if @teacher_info.update_attributes(params[:teacher_info])
    			format.html { redirect_to @teacher } 
        	else
          		format.html { render :action => "edit" }
        	end
    	end
 	 end

     def teacher_protect
        if session[:teacher_id].nil?
            redirect_to buptiet_url, :notice => "Login"
            return false
        end
    end
  
end
