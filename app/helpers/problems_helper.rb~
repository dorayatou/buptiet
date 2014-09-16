module ProblemsHelper
	def problem_students(problem_id)
		if student_lists = AnswerStudentList.where('problem_id = ?', problem_id)
		 student_lists
		end	 
	end

	def have_preview?
		 current_course = Course.find(session[:course_id])
		 Preview.where('course_id = ?', current_course.id).present?
	end

end
