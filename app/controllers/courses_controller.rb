class CoursesController < ApplicationController
  # 展示选修某门课程的所有学生
  def student_list
    @course = Course.find(params[:id])
    # @course = Course.where("course_id = ? AND teacher_id = ?", course_id, session[:teacher_id])
    @students = @course.students
  end
  # 管理员页面课程首页
  def index
    @courses = Course.order(:identifier)
  end
  
	def show
		@course = Course.find(params[:id])
		@academy = Academy.find(@course.academy_id)
	end

	def new
		@course = Course.new
	end

	def create
		@course = Course.new(params[:course])
		@course.academy_id = params[:academy_id]

    	respond_to do |format|
      		if @course.save
        		format.html { redirect_to courses_path, notice: 'success' }
      		else
        		format.html { render action: "new" }
      		end
    	end
	end

	def edit
  	@course = Course.find(params[:id])
  end

  def update
  	@course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to  @course, :notice => "updated" } 
      else
        format.html { render :action => "edit" }
      end
    end

  end

  def destroy
    @course = Course.find(params[:id])
    @course.delete

    respond_to do |format|
      format.html { redirect_to courses_path }
    end
  end

end
