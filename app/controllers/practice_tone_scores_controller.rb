class PracticeToneScoresController < ApplicationController
	def index
        @current_course = Course.find(params[:course_id])
        @current_quiz = Quiz.find(params[:quiz_id])
		@datas = PracticeToneScore.order("created_at DESC")
	end

	def create
        @student_info = StudentInfo.find_by_name(params[:name])
		@data = params[:DataBaseContent]
        a1 = Array.new
        a1 = ActiveSupport::JSON.decode(@data)
        a1.each do |a|
        	@new_record = PracticeToneScore.new(:consume_time => a["consume_time"],:first_tone_char => a["first_tone_char"],:is_covered =>  a["is_covered"], :correct => a["correct"], :second_tone_char => a["second_tone_char"])
            @new_record.student_id = @student_info.student_id
            @new_record.save
        end
        render(:text => 'success')
	end
end