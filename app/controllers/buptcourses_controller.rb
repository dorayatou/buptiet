class BuptcoursesController < ApplicationController
  # coding: utf-8
  def index
    @courses = Buptcourse.find(:all)
    render template: "buptcourses/index.json.rabl"
  end
  
  def show
    @course = Buptcourse.find(params[:id])
    render template: "buptcourses/show.json.rabl"
  end
  
  def show_lesson
    @lesson = Buptlesson.find(params[:id])
    render template: "buptcourses/show_lesson.json.rabl"
  end
  
  def show_course_exercise
    @exercises = Buptexercise.find_all_by_buptcourse_id(params[:id])
    render template: "buptcourses/show_exercise.json.rabl"
  end
  
  def show_lesson_exercise
    @exercises = Buptexercise.find_all_by_buptlesson_id(params[:id])
    render template: "buptcourses/show_exercise.json.rabl"
  end
  
  def show_course_comment
    @comments = Buptcomment.order("comment_time desc").find_all_by_buptcourse_id(params[:id])
    render template: "buptcourses/show_comment.json.rabl"
  end
  
  def show_lesson_comment
    @comments = Buptcomment.order("comment_time desc").find_all_by_buptlesson_id(params[:id])
    render template: "buptcourses/show_comment.json.rabl"
  end
  
  # 返回search内容
  def search
    if params[:content].blank?
      render :text => ""
      return
    end
    # @Buptcourses = Redis::Search.complete("Buptcourse", params[:content])
    # @Buptcourses = Buptcourse.where("Buptcourse_name LIKE ? or Buptcourse_lecturer LIKE ? or Buptcourse_intro LIKE ? or Buptcourse_lecturer_intro LIKE ?", "%#{params[:content]}%", "%#{params[:content]}%", "%#{params[:content]}%", "%#{params[:content]}%")
    @courses = Buptcourse.where("course_name LIKE ?", "%#{params[:content]}%")
    render template: "buptcourses/search.json.rabl"
  end
  
  def insert_course_comment
    if 1
    @comment = Buptcomment.new(params[:comment])
    comment = @comment
    comment.buptcourse_id = params[:course_id]
    comment.buptlesson_id = 0
    comment.user_name = params[:user_name]
    comment.comment_content = params[:comment_content]
    comment.comment_time = params[:comment_time]
      if comment.save
        render(:text => "insert comment success")
      else
        render(:text => "insert comment error")
      end
    # else
    #   render(:text => "invalid url")
    end
  end
  
  def insert_lesson_comment
      if 1
        @comment = Buptcomment.new(params[:comment])
        comment = @comment
        comment.buptcourse_id = 0
        comment.buptlesson_id = params[:lesson_id]
        comment.user_name = params[:user_name]
        comment.comment_content = params[:comment_content]
        comment.comment_time = params[:comment_time]
          if comment.save
            render(:text => "insert comment success")
          else
            render(:text => "insert comment error")
          end
       # else
       #    render(:text => "invalid url")
       end
  end
  # 方便从前台添加数据
  def new
    @buptcourse = Buptcourse.new
  end

  def create
    @buptcourse = Buptcourse.new(params[:buptcourse])
  
    respond_to do |format|
      if @buptcourse.save
        format.html { redirect_to newcourse_info_path, :notice => "success" }
      else
        format.html { render action: "new"}
      end
    end
  end

end
