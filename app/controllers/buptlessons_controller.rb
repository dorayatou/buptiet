class BuptlessonsController < ApplicationController
	# 方便从前台添加数据
  def new
  	@buptcourse = Buptcourse.find(params[:buptcourse_id])
    @buptlesson = Buptlesson.new
  end

  def create
  	# @buptcourse = Buptcourse.find(params[:buptcourse_id])
    @buptlesson = Buptlesson.new(params[:buptlesson])

    buptcourse_id = params[:buptcourse_id]
    @buptlesson.buptcourse_id = buptcourse_id
  
    respond_to do |format|
      if @buptlesson.save
        format.html { redirect_to newlesson_info_path(buptcourse_id), :notice => "success" }
      else
        format.html { render action: "new"}
      end
    end
  end
end
