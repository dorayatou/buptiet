class BuptfavoritesController < ApplicationController
	def insert_favorite
    fav = Buptfavorite.verify(params[:user_name], params[:course_id], params[:course_name])
    if fav.nil?
      @fav = Buptfavorite.new(params[:favorite])
      @fav.user_name = params[:user_name]
      @fav.buptcourse_id = params[:course_id]
      @fav.course_name = params[:course_name]
      @fav.favo_time = params[:favo_time]
      if @fav.save
        render(:text => "insert favorite success")
      else
        render(:text => "insert favorite error")
      end
    else
      render(:text => "this favorite repeat")
    end
  end
  
  def show_user_fav
    @favorites = Buptfavorite.order("favo_time desc").find_all_by_user_name(params[:user_name])
    render template: "buptfavorites/show_user_fav.json.rabl"
  end
  
  def destory
    @favorite = Buptfavorite.pass(params[:user_name], params[:course_id])
    @favorite.delete

    if @favorite.nil?
      render(:text => "delete favorite error")
    else
      render(:text => "delete favorite success")
    end
  end
end
