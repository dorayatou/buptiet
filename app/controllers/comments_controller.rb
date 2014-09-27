class CommentsController < ApplicationController
	# 教师页面的评论系统
	def index
		@group = Group.find(params[:group_id])
		@post = Post.find(params[:post_id])
		@comments = Comment.where("post_id = ?", params[:post_id])
	end
	# 学生页面的评论系统
	def student_comments
		@group = Group.find(params[:group_id])
		@post = Post.find(params[:post_id])
		@comments = Comment.where("post_id = ?", params[:post_id])
	end

	def new
		@group = Group.find(params[:group_id])
		@post = Post.find(params[:post_id])
		@comment = Comment.new
	end

	def create
		@group = Group.find(params[:group_id])
		@post = Post.find(params[:post_id])
		@comment = Comment.new(params[:comment])
		@comment.post_id = params[:post_id]
		if session[:teacher_id]
			@comment.teacher_id = session[:teacher_id]
			@comment.student_id = nil
		elsif session[:student_id]
			@comment.student_id = session[:student_id]
			@comment.teacher_id = nil
		end

		respond_to do |format|
			if @comment.save
				if session[:teacher_id]
					format.html { redirect_to group_post_path(@group, @post), :notice => "success" }
				elsif session[:student_id]
					format.html { redirect_to student_show_post_path(@group, @post), :notice => "success" }
				end
			else
				format.html { render :action => "new" }
			end
		end
	end

	def new_message_comment
		if session[:teacher_id]
            @teacher_info = TeacherInfo.find_by_teacher_id(session[:teacher_id])
        elsif session[:student_id]
            @student_info = StudentInfo.find_by_student_id(session[:student_id])
        end
		@post = Post.find(params[:id])
		@comment = Comment.new
	end

	def create_message_comment
		if session[:teacher_id]
            @teacher_info = TeacherInfo.find_by_teacher_id(session[:teacher_id])
        elsif session[:student_id]
            @student_info = StudentInfo.find_by_student_id(session[:student_id])
        end
		@post = Post.find(params[:id])
		@comment = Comment.new(params[:comment])
		@comment.post_id = params[:id]
		if session[:teacher_id]
			@comment.teacher_id = session[:teacher_id]
			@comment.student_id = nil
		elsif session[:student_id]
			@comment.student_id = session[:student_id]
			@comment.teacher_id = nil
		end

		respond_to do |format|
			if @comment.save
				format.html {  redirect_to show_message_path(@post), :notice => "success" }
			else
				format.html { render :action => "new_message_comment" }
			end
		end

	end

	def edit
		@group = Group.find(params[:group_id])
		@post = Post.find(params[:post_id])
		@comment = Comment.find(params[:id])
	end

	def update
		@group = Group.find(params[:group_id])
		@post = Post.find(params[:post_id])
		@comment = Comment.find(params[:id])

		respond_to do |format|
			if @comment.update_attributes(params[:comment])
				if session[:teacher_id]
					format.html { redirect_to group_post_comments_path(@group, @post), :notice => "success" }
				elsif session[:student_id]
					format.html { redirect_to student_comments_path(@group, @post), :notice => "success" }	
				end	
			else
				format.html { render :action => "edit" }
			end
		end
	end

	def destroy
		@group = Group.find(params[:group_id])
		@post = Post.find(params[:post_id])
		@comment = Comment.find(params[:id])
		@comment.destroy

		respond_to do |format|
			if session[:teacher_id]
				format.html { redirect_to group_post_path(@group, @post) }
			elsif session[:student_id]
				format.html { redirect_to student_show_post_path(@group, @post) }
			end
		end
	end

	def destroy_message_comment
		@post = Post.find(params[:post_id])
		@comment = Comment.find(params[:id])
		@comment.destroy

		respond_to do |format|
			if session[:teacher_id]
				format.html { redirect_to show_message_comments_path(@post) }
			elsif session[:student_id]
				format.html { redirect_to show_message_comments_path(@post) }
			end
		end
	end

end
