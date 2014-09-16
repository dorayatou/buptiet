class OpinionsController < ApplicationController
	include ApplicationHelper
	# before_filter :teacher_protect

	def new
		@opinion = Opinion.new
		@topic = Topic.find_by_id(params[:topic_id])

		respond_to do |format|
      		format.html
    	end
	end

	def create
		@opinion = Opinion.new(params[:opinion])
		@topic = Topic.find_by_id(params[:topic_id])
		@opinion.topic_id = @topic.id
		@opinion.select_count = 0

		respond_to do |format|
			if @opinion.save
				format.html { redirect_to new_topic_opinion_path(@topic), :notice => "#{@topic.opinions.count} opinions" }
			else
				format.html { render :action => "new" }
			end
		end
	end

	def destroy
		@opinion = Opinion.find(params[:id])
		@opinion.destroy

		respond_to do |format|
			format.html { redirect_to :controller => "topic", :action => "show" }
		end
	end

	def teacher_protect
		if session[:teacher_id].nil?
			redirect_to buptiet_url, :notice => "Login"
			return false
		end
	end
	
end