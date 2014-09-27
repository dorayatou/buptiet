module ApplicationHelper
	def student?
    Student.where('id = ?', session[:student_id]).present?		
	end

	def teacher?
		Teacher.where('id = ?', session[:teacher_id]).present?
	end
		

	# 确定当前时间是否为上课时间段（没有考虑年、月、日或者周情况）
	# def time_to_period(time)
	# 	time_array = time.to_a
	# 	time_array[2] = case period
	# 		when 8..10  then "1"
	# 		when 10..12 then "2"
	# 		when 13..15 then "3"
	# 		when 15..17 then "4"
	# 	end
	# end

end
