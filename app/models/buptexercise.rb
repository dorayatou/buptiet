class Buptexercise < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :buptexercise_id, :buptcourse_id, :buptlesson_id, :question_type, :question_num, :question,
   					:option_a, :option_b, :option_c, :option_d, :answer, :analysis
end
