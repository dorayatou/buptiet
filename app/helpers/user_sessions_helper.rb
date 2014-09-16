module UserSessionsHelper
	def current_time
		current_time = Time.new
    	current_period = time_to_period(current_time)
    	current_year = current_time.to_a[5]
    	current_month = current_time.to_a[4]
    	current_day = current_time.to_a[3]
	end
end
