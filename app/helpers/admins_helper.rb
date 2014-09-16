module AdminsHelper
	def admin_login
		unless session[:admin_id]
      		redirect_to buptiet_url, :alert => "Please login first!"
      		return false
    	end
	end	
end
