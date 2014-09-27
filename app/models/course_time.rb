class CourseTime < ActiveRecord::Base
	# 课程时间与课程的关系
	belongs_to :course 
	
  attr_accessible :course_id, :weekday, :period, :year, :month
	
	def self.current_course_id(ids)
		course_ids = []
		ids.each do |id|
			course_ids << self.current_time_table.where('course_id = ?', id)
		end
		course_ids[0][0].try(:course_id)
	end

	def self.current_time_table
		time = Time.now
    weekday = time.wday 
    period = current_period(time)
		where('weekday = ? and period = ?', weekday, period) 
	end

	def self.current_period(time)
    time_array = time.to_a
    if (time_array[2] >= 0 and time_array[2] < 24)
      return 1
    # elsif (time_array[2] >= 22 and time_array[2] < 23)
    #   return 2
    # elsif (time_array[2] >= 23 and time_array[2] < 24)
    #   return 3
    # elsif (time_array[2] >= 24 and time_array[2] < 8)
    #   return 4
    end
	end

end
