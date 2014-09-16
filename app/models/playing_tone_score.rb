class PlayingToneScore < ActiveRecord::Base
	attr_accessible :student_id, :consume_time, :target_tone_char, :correct, :selected_tone_char
end