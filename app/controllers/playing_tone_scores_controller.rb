class PlayingToneScoresController < ApplicationController
	def index
        @student_info = StudentInfo.find_by_name(params[:name])
        @current_course = Course.find(params[:course_id])
        @current_quiz = Quiz.find(params[:quiz_id])
        @dates = PlayingToneScore.order("created_at DESC")
		# @datas = PlayingToneScore.order("created_at DESC").limit(15)
	end

	def create
        @student_info = StudentInfo.find_by_name(params[:name])
		@data = params[:DataBaseContent]
        a1 = Array.new
        a1 = ActiveSupport::JSON.decode(@data)
        a1.each do |a|
        	@new_record = PlayingToneScore.new(:target_tone_char => a["target_tone_char"], :consume_time => a["consume_time"], :correct => a["correct"], :selected_tone_char => a["selected_tone_char"])
            @new_record.student_id = @student_info.student_id
            @new_record.save
        end

        render(:text => "success")
	end
end