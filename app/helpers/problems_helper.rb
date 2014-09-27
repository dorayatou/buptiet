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

  def asked?(problem_id)
		student = Student.find(session[:student_id])
    ProblemStudent.where('student_id = ? and problem_id = ?', student.id, problem_id).present?
  end

	def answered?(problem_id)
		AnswerStudentList.where('student_id = ? and problem_id = ?', session[:student_id], problem_id).present?
	end

	def student?
    Student.where('id = ?', session[:student_id]).present?		
	end

	def teacher?
		Teacher.where('id = ?', session[:teacher_id]).present?
	end
end
