class VotesController < ApplicationController
	def index
		# session[:votes_path] = "index" 
		@latest_votes = Topic.order("created_at DESC").limit(5)
		@hot_votes = Topic.order("cast_count DESC").limit(5)
	end

	def show_all_votes
		# session[:votes_path] = "votes"
		@topics = Topic.all 
	end

	def show_hot_votes
		# session[:votes_path] = "hot"
		@hot_votes = Topic.order("cast_count DESC").limit(5)
	end

	def show_latest_votes
		# session[:votes_path] = "latest"
		@latest_votes = Topic.order("created_at DESC").limit(5)		
	end	

	def show_all_lastest
		# session[:votes_path] = "all_lastest"
		@topics = Topic.order("created_at DESC")
	end

	def show_all_hot
		# session[:votes_path] = "all_hot"
		@topics = Topic.order("cast_count DESC")
	end

	def show_vote
		@student = Student.find(session[:student_id])
		@topic = Topic.find(params[:topic_id])
		@opinions = @topic.opinions
		@check_vote = Vote.find_by_student_id_and_topic_id(@student.id, @topic.id)
		# @check_vote = Vote.where("student_id = ? AND topic_id = ?", @student.id, @topic.id)
		@opinion_all_tags = ["A","B","C","D","E","F","G","H"]

		if not @check_vote.nil?
			# 图表url @vote_results
			@vote_results = "t:"
			@opinions = Opinion.where("topic_id = ?", @topic.id)
			count_flag = @opinions.count
			# 选票总票数
			@total_votes = @topic.cast_count
			@opinions.each do |opinion|
				if count_flag == 1
					@vote_results = @vote_results + (opinion.select_count * 10).to_s
				else
					@vote_results = @vote_results + (opinion.select_count * 10).to_s + ",".to_s
					count_flag = count_flag - 1
				end
			end
			# @vote_results = "http://chart.apis.google.com/chart?chs=300x190&chtt=total:#{@total_votes}&chts=0000FF,20&chd=#{@vote_results}&cht=p3&chxt=x,y&chxl=0:|A|B|C|D|E|F|1:|0|1|2|3|4|5|6|7|8|9|10"  
			@vote_results = "http://chart.apis.google.com/chart?chs=300x190&cht=p&chco=00FFFF,0080FF,00C800,FFFF00,BB0060&chts=0000FF,20&chd=#{@vote_results}&chxt=x,y&chxl=0:|A|B|C|D|E|F|1:|0|1|2|3|4|5|6&chtt=total:#{@total_votes}"  
		
		end	

		respond_to do |format|
			format.html
		end
	end

	def cast_vote
		@student = Student.find(session[:student_id])
		@topic = Topic.find(params[:topic_id])
		cast_count = @topic.cast_count
		@select_opinion = Opinion.find(params[:opinion_id])
		select_count = @select_opinion.select_count
		topic_flag = 0
		if not @select_opinion.nil?
			@vote = Vote.new(:student_id => session[:student_id], :topic_id => @topic.id, :opinion_id => @select_opinion.id)
			topic_flag = 1
		else
			topic_flag = 2
		end

		respond_to do |format|
			if topic_flag == 1
				if @vote.save
					cast_count = cast_count + 1
					select_count = select_count + 1
					if @topic.update_attributes(:cast_count => cast_count) and @select_opinion.update_attributes(:select_count => select_count)
						format.html { redirect_to show_vote_path(@topic), :notice => "success" }
					else
						format.html { redirect_to show_vote_path(@topic), :notice => "fail!" }
					end
				else
					format.html { redirect_to show_vote_path(@topic), :notice => "fail!" } 
				end
			elsif topic_flag == 2
				format.html { redirect_to show_vote_path(@topic), :notice => "select!" } 				
			end
		end
	end

	def show_vote_result
		@student = Student.find(session[:student_id])
		@topic = Topic.find(params[:topic_id])
		@opinions = @topic.opinions
		@vote = Vote.find_by_student_id_and_topic_id(@student.id, @topic.id)
		if not @vote.nil?
			@vote_results = "t:"
			@opinions = Opinion.where("topic_id = ?", @topic.id)
			count_flag = @opinions.count
			@total_votes = @topic.cast_count
			@opinions.each do |opinion|
				if count_flag == 1
					@vote_results = @vote_results + (opinion.select_count * 10).to_s
				else
					@vote_results = @vote_results + (opinion.select_count * 10).to_s + ",".to_s
					count_flag = count_flag - 1
				end
			end
			# @vote_results = "http://chart.apis.google.com/chart?chs=300x190&chtt=total:#{@total_votes}&chts=0000FF,20&chd=#{@vote_results}&cht=p3&chxt=x,y&chxl=0:|A|B|C|D|E|F|1:|0|1|2|3|4|5|6|7|8|9|10"  
			@vote_results = "http://chart.apis.google.com/chart?chs=300x190&chtt=total:#{@total_votes}&chts=0000FF,20&chd=#{@vote_results}&cht=p3&chxt=x,y&chxl=0:|A|B|C|D|E|F|1:|0|1|2|3|4|5|6|7|8|9|10"  
		end
		@vote_results = "http://chart.apis.google.com/chart?chs=300x190&chtt=total:#{@total_votes}&chts=0000FF,20&chd=#{@vote_results}&cht=p3&chxt=x,y&chxl=0:|A|B|C|D|E|F|1:|0|1|2|3|4|5|6|7|8|9|10"  
		respond_to do |format|
      		format.html
    	end
	end

	def show_all_mine_refered
    	@votes = Vote.where("student_id = ?", session[:student_id]).order("created_at DESC")

    	respond_to do |format|
        	format.html
    	end
  	end

  	def show_my_refered_vote
  		@student = Student.find(session[:student_id])
    	@topic = Topic.find(params[:topic_id])
    	@opinions = @topic.opinions
    	@vote = Vote.find_by_student_id_and_topic_id(@student.id, @topic.id)
    	@opinion_all_tags = ["A","B","C","D","E","F","G","H"]
    	@vote_results = "t:"
    	@opinions = Opinion.where("topic_id = ?", @topic.id)
    	count_flag = @opinions.count
    	@total_votes = @topic.cast_count
    	@opinions.each do |opinion|
    		if count_flag == 1
    			@vote_results = @vote_results + (opinion.select_count * 10).to_s
    		else
    			@vote_results = @vote_results + (opinion.select_count * 10).to_s + ",".to_s
    			count_flag = count_flag - 1
    		end
    	end

    	# @vote_results = "http://chart.apis.google.com/chart?chs=300x190&chtt=total:#{@total_votes}&chts=0000FF,20&chd=#{@vote_results}&cht=p3&chxt=x,y&chxl=0:|A|B|C|D|E|F|1:|0|1|2|3|4|5|6|7|8|9|10"  
  		respond_to do |format|
        	format.html
    	end
  	end

end
