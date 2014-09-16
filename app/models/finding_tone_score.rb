class FindingToneScore < ActiveRecord::Base
	attr_accessible :student_id, :consume_time, :target_tone_char, :correct, :compare_tone_char
end