object @course

attributes :buptcourse_id, :course_type, :course_name, :course_lecturer,
			:course_lecturer_intro, :course_intro, :course_image

child :buptlessons => :lesson_fileds do
	attributes :buptlesson_id, :buptcourse_id, :lesson_num, :lesson_name
end
			

