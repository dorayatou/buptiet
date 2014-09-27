class ApplicationController < ActionController::Base
	protect_from_forgery
  
  def time_to_period(time)
    time_array = time.to_a
    
    if (time_array[2] >= 0 and time_array[2] < 24)
      return 1
    # elsif (time_array[2] >= 22 and time_array[2] < 23)
    #   return 2
    # elsif (time_array[2] >= 23 and time_array[2] < 24)
    #   return 3
    # elsif (time_array[2] >= 24 and time_array[2] < 8)
    #   return 4
    end
  end


	def current_student
		Student.find(session[:student_id])
	end

	def current_teacher
		Teacher.find(session[:teacher_id])
	end

	def current_course
		begin
			Course.find(session[:course_id])
		rescue ActiveRecord::RecordNotFound
			nil
		end
	end
  

end
