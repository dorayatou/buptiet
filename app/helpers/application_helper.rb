module ApplicationHelper
	def student?
		session[:student_id].present?
	end

	def teacher?
		session[:teacher_id].present?
	end
		
end
