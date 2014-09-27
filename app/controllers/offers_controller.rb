class OffersController < ApplicationController
	def index
		@offers = Offer.order(:identifier).all
	end

	def show
		@offer = Offer.find(params[:id])
		@course = Course.find(@offer.course_id)
		@teacher_info = TeacherInfo.find(@offer.teacher_id)
	end

	def edit
		@offer = Offer.find(params[:id])
		@courses = Course.order(:identifier).all 
		@teacher_infos = TeacherInfo.order(:teacher_id).all
	end

	def new
		@offer = Offer.new
		@courses = Course.order(:identifier).all 
		@teacher_infos = TeacherInfo.order(:teacher_id).all
	end

	def create
		@offer = Offer.new(params[:offer])
		@offer.course_id = params[:course_id]
		@offer.teacher_id = params[:teacher_id]
		
		respond_to do |format|
			if @offer.save
				format.html {
					redirect_to offers_path, :notice => 'success' }
			else
				format.html { render :action => "new" }
			end
		end
	end

	def destroy
		@offer = Offer.find(params[:id])
		@offer.destroy

		respond_to do |format|
			format.html { redirect_to offers_path }
		end
	end

end
