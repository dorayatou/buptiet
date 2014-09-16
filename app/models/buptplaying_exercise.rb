class BuptplayingExercise < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :buptplaying_exercise_id, :buptlesson_id, :question_type, :question_num, 
   					:pause_time, :question, :option_a, :option_b, :option_c, :option_d,
   					:answer, :analysis
end
