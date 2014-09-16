class FindingToneScoresController < ApplicationController
	def index
        @current_course = Course.find(params[:course_id])
        @current_quiz = Quiz.find(params[:quiz_id])
		@datas = FindingToneScore.order("created_at DESC")
	end

	def create
        @student_info = StudentInfo.find_by_name(params[:name])
		@data = params[:DataBaseContent]
        a1 = Array.new
        a1 = ActiveSupport::JSON.decode(@data)
        a1.each do |a|
        	@new_record = FindingToneScore.new(:target_tone_char => a["target_tone_char"], :compare_tone_char => a["compare_tone_char"], :consume_time => a["consume_time"], :correct => a["correct"])
            @new_record.student_id = @student_info.student_id
            @new_record.save
        end
        render(:text => "success")
	end
end