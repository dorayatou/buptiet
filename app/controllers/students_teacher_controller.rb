class StudentsTeachersController < ApplicationController
	def new
		@students_teacher = StudentsTeacher.new
	end
end