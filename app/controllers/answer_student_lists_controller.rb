class AnswerStudentListsController < ApplicationController
	#我要回答，学生添加进列表
	def add_student_to_list
		student = Student.find(session[:student_id])
		problem_id = params[:problem_id]
    @new_student_list = AnswerStudentList.create(student_id: student.id, problem_id: problem_id)
		@new_student_list.save
    
		respond_to do |format|
			format.html { redirect_to index_student_problems_path }
		end
	end
end
