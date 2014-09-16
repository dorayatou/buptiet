class Buptcomment < ActiveRecord::Base
  attr_accessible :buptcourse_id, :buptlesson_id, :user_name, :comment_content, :comment_time
end
