class BoxesController < ApplicationController

	def show
		@box = Box.find(params[:id])
		topic_id = @box.topic_id
		@topic = Topic.find_by_id(topic_id)
	end

	def new
		@box = Box.new
	end

	def create
		@box = Box.new(params[:box])

		respond_to do |format|
			if @box.save
				format.html { redirect_to @box, :notice => "Box has successfully created" }
			else
				format.html { render :action => "new" }
			end
		end
	end

	def destroy
		@box = Box.find(params[:id])
		@box.destroy
	end
	
end