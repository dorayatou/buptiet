class BuptexercisesController < ApplicationController
	def show
    	@playingexercise = BuptplayingExercise.find_all_by_buptlesson_id(params[:lesson_id])
    	render template: "buptexercises/show.json.rabl"
  	end

	  # 方便从前台添加数据
	def new
		# @buptcourse = Buptcourse.find(params[:buptcourse_id])
		# @buptlesson = Buptlesson.find(params[:buptlesson_id])
		@buptexercise = Buptexercise.new
	end

	def create
	    @buptexercise = Buptexercise.new(params[:buptexercise])
	    
	    # buptcourse_id = params[:buptcourse_id]
	    # buptlesson_id = params[:buptlesson_id]

	 #    @buptcourse = Buptcourse.find(params[:buptcourse_id])
		# @buptlesson = Buptlesson.find(params[:buptlesson_id])

		# @buptexercise.buptcourse_id = buptcourse_id
		# @buptexercise.buptlesson_id = buptlesson_id

	  
	    respond_to do |format|
	      if @buptexercise.save
	        format.html { redirect_to newexercise_info_path, :notice => "success" }
	      else
	        format.html { render action: "new"}
	      end
	    end
	end
end
