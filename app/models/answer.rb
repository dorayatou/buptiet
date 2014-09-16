class Answer < ActiveRecord::Base
	# 回答与学生的关联
	belongs_to :student 
	# 答案与试题的关联
	belongs_to :question
	
    attr_accessible :student_id, :question_id, :option_id, :correct, :quiz_id, :fav_flag

    # def verdict
    	
    # end

    # def Answer.test_time(exercise_id)
    # 	student = Student.find(session[:student_id])
    # 	exercise = Quiz.find(exercise_id)
    # 	questions = Question..order("created_at").where("quiz_id = ?", exercise.id)
    # 	questions.collect do |question|
    # 		answers = Answer.order("question_id").where("question_id = ? AND student_id = ?", question.id, student.id)
    # 	end
    # 	first_answer = answers.first
    # 	first_answer_time = first_answer.created_at.to_a
    # 	first_answer_time_min = first_answer_time[1]
    # 	first_answer_time_hour = first_answer_time[2]
    # 	last_answer = answers.last 
    # 	last_answer_time = last_answer.created_at.to_a
    # 	last_answer_time_min = last_answer_time[1]
    # 	last_answer_time_hour = last_answer_time[2]

    # 	if last_answer_time_hour == first_answer_time_hour
    # 		test_time = last_answer_time_min - first_answer_time_min
    # 	elsif last_answer_time_hour == first_answer_time_hour + 1
    # 		test_time = last_answer_time_min - first_answer_time_min + 60
    # 	end

    # 	return test_time
    # end

end
