class OpenApiAnswer < ActiveRecord::Base
   attr_accessible :student_id, :quiz_id, :question_id, :option_id, :correct

	def write_option(option_id, option_tags)
	 	case option_id
		when 'A' then 
			option_id = option_tags[0]
		when 'B' then
			option_id = option_tags[1]
		when 'C' then
			option_id = option_tags[2]
		when 'D' then
			option_id = option_tags[3]
		end
	end

end
