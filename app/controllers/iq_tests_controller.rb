class IqTestsController < ApplicationController
	def create
		@data = params[:iq_tests]
        a1 = Array.new
        a1 = ActiveSupport::JSON.decode(@data)
        a1.each do |a|
        	@new_record = IqTest.new(:question_num => a["question_num"], :question_item => a["question_item"], :score_item => a["score_item"], :score => a["score"], :consume_time => a["consume_time"])
            @new_record.save
        end
        render(:text => "success")
	end
end
