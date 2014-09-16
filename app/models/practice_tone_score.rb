class PracticeToneScore < ActiveRecord::Base
	attr_accessible :consume_time, :first_tone_char, :is_covered, :correct, :second_tone_char, :student_id
end