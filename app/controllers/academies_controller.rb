class AcademiesController < ApplicationController
	def index
		@academies = Academy.all 
	end

	def new
		@academy = Academy.new
	end

	def create
		@academy = Academy.new(params[:academy])

		respond_to do |format|
			if @academy.save
				format.html { redirect_to  }
			else
				format.html { render :action => :new }
			end
		end
	end
end