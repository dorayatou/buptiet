module AnswerStudentListsHelper
	def problem_students(problem_id)
		if student_lists = AnswerStudentList.where('problem_id = ?', problem_id)
		  student_ids = student_lists.map(&:student_id).uniq
			students_name = []
			student_ids.each do |student_id|
				name = StudentInfo.where('student_id = ?', student_id)[0].name
				students_name << name
			end
			return students_name
		end
	end
end
