class AdminInfosController < ApplicationController
	include ApplicationHelper
	# before_filter :admin_protect

	def new
		@admin_info = AdminInfo.new
	end

	def admin_protect
		if session[:admin_id].nil?
			redirect_to buptiet_url, :alter => "Login!"
			return false
		end
	end
	
end
