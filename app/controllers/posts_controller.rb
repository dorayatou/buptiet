class PostsController < ApplicationController
	include ApplicationHelper
	# before_filter :teacher_protect, :only => [:index, :show]
	# before_filter :student_protect, :only => [:student_posts, :student_show_post]

	# 教师页面群组消息系统
	def index
		@group = Group.find(params[:group_id])
		@student_posts = Post.order("created_at DESC").where("group_id = ? AND student_id", params[:group_id])
		@teacher_posts = Post.order("created_at DESC").where("group_id = ? AND teacher_id", params[:group_id])
	end

	# 展示学生页面群组消息系统
	def student_posts
		@group = Group.find(params[:group_id])
		@student_posts = Post.order("created_at DESC").where("group_id = ? AND student_id", params[:group_id])
		@teacher_posts = Post.order("created_at DESC").where("group_id = ? AND teacher_id", params[:group_id])
	end

	def show
		@group = Group.find(params[:group_id])
		@post = Post.find(params[:id])
		@comments = Comment.where("post_id = ?", @post.id)
		@student_info = StudentInfo.find_by_student_id(@post.student_id)
		@teacher_info = TeacherInfo.find_by_teacher_id(@post.teacher_id)
	end

	# 学生页面的群组消息中的一条消息详情
	def student_show_post
		@group = Group.find(params[:group_id])
		@post = Post.find(params[:id])
		@comments = Comment.where("post_id = ?", @post.id)
		@student_info = StudentInfo.find_by_student_id(@post.student_id)
		@teacher_info = TeacherInfo.find_by_teacher_id(@post.teacher_id)
	end

	def new
		@group = Group.find(params[:group_id])
		@post = Post.new
	end

	# def new_student_post
	# 	@group = Group.find(params[:group_id])
	# 	@post = Post.new
	# end

	def create
		@group = Group.find(params[:group_id])
		@post = Post.new(params[:post])
		@post.group_id = params[:group_id]
		if session[:teacher_id]
			@post.teacher_id = session[:teacher_id]
		elsif session[:student_id]
			@post.student_id = session[:student_id]
		end

		respond_to do |format|
			if @post.save
				if session[:teacher_id]
					format.html { redirect_to group_posts_path(@group), :notice => "success." }
				else session[:student_id]
					format.html { redirect_to student_posts_path(@group), :notice => "success" }
				end
			else
				format.html { render :action => "new" }
			end
		end
	end


	def edit
		@group = Group.find(params[:group_id])
		@post = Post.find(params[:id])
	end

	def edit_student_post
		@group = Group.find(params[:group_id])
		@post = Post.find(params[:id])
	end

	def destroy
		@group = Group.find(params[:group_id])
		@post = Post.find(params[:id])
		@post.destroy
		@post.comments.destroy

		respond_to do |format|
				if session[:teacher_id]
					format.html { redirect_to group_posts_path(@group), :notice => "success." }
				else session[:student_id]
					format.html { redirect_to student_posts_path(@group), :notice => "success" }
				end
		end
	end

	def teacher_protect
		if session[:teacher_id].nil?
			redirect_to buptiet_url, :notice => "Login"
			return false
		end
	end

	def student_protect
		if session[:student_id].nil?
			redirect_to buptiet_url, :notice => "Login"
			return false
		end
	end

end
