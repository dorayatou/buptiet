class TopicsController < ApplicationController
	# 教师登陆进去的投票系统的主页
	def index
		session[:topics_path] = "index"
		@topics = Topic.all 
		@latest_topics = Topic.order("created_at DESC").limit(5)
		@hot_topics = Topic.order("cast_count DESC").limit(5)
	end

	def show
		@topic = Topic.find(params[:id])
		@opinions = @topic.opinions
	end

	def show_my_topics
		session[:topics_path] = "mine"
		@my_topics = Topic.where("teacher_id = ?", session[:teacher_id])
	end

	def show_all_topics
		session[:topics_path] = "topics"
		@topics = Topic.all 
	end

	def show_latest_topics
		session[:topics_path] = "latest"
		@latest_topics = Topic.order("created_at DESC").limit(3)		
	end

	def show_hot_topics
		session[:topics_path] = "hot"
		@hot_topics = Topic.order("cast_count DESC").limit(3)
	end

	def show_all_lastest
		@topics = Topic.order("created_at DESC")
	end

	def show_all_hot
		@topics = Topic.order("cast_count DESC")
	end

	
	def new
		@topic = Topic.new
	end

	def create
		@topic = Topic.new(params[:topic])
		# 判断投票人是教师还是学生？
		if not session[:teacher_id].nil?
			@topic.teacher_id = session[:teacher_id]
		elsif not session[:student_id].nil?
			@topic.student_id = session[:student_id]	
		end
		@topic.cast_count = 0

		respond_to do |format|
			if @topic.save
				format.html { redirect_to new_topic_opinion_path(@topic) }
			else
				format.html { render :action => "new" }
			end
		end
	end

	def destroy
		@topic = Topic.find(params[:id])
		@topic.destroy

		respond_to do |format|
			format.html { redirect_to topics_path }
		end
	end

end
