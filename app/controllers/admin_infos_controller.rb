class AdminInfosController < ApplicationController
	def new
		@admin_info = AdminInfo.new
	end
end
