#coding： utf-8
class UserSessionsController < ApplicationController
  include ApplicationHelper
  def login
      admin = Admin.authenticate(params[:identifier], params[:password])
      student = Student.authenticate(params[:identifier], params[:password])
      teacher = Teacher.authenticate(params[:identifier], params[:password])
      
      if admin
        session[:admin_id] = admin.id
        redirect_to admins_path
      elsif teacher
        session[:teacher_id] = teacher.id
        redirect_to teachers_path
      elsif student
        session[:student_id] = student.id
        redirect_to students_path
      else
        redirect_to login_path, :notice => "invalid" 
      end
  end

  def logout
    if admin?
        session[:admin_id] = nil
    elsif student?
        session[:course_id] = nil
        session[:student_id] = nil
    elsif teacher?
        session[:course_id] = nil
        session[:teacher_id] = nil
    end
 		redirect_to login_path, :notice => "logout"		
  end

  # 精细辨认登陆与登出方法
  def login_a
    student = Student.authenticate(params[:identifier], params[:password])
    if student
      session[:student_id] = student.id
      render(:text => 'success')
    else
      render(:text => 'fail')
    end
  end

  def logout_a
    session[:student_id] = nil
    render(:text => 'logout')
  end
  
  # 儿童智力测试登录与登出方法
  def login_c
    student = Student.authenticate(params[:identifier], params[:password])
    if student
      session[:student_id] = student.id
      # render(:text => 'success')
      @student_info = StudentInfo.find_by_student_id(student.id)
      render(:text => "#{@student_info.name}")
    else
      render(:text => 'fail')
    end
  end

  # buptcourse视频公开课登陆与登出方法
  def login_b
    student = Student.authenticate(params[:identifier], params[:password])
    if student
      # session[:student_id] =  student.id
      render(:text => 'Login success')
    else
      render(:text => 'Login error')
    end
  end

	private
	
	def admin?
		session[:admin_id].present?
	end

	def student?
		session[:student_id].present?
	end

	def teacher?
		session[:student_id].present?
	end

end
