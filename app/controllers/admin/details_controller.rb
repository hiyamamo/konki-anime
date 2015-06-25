class Admin::DetailsController < ApplicationController
	def destroy
		detail = Detail.find params[:id]
		detail.destroy
		redirect_to :back
	end

	def edit
		@detail = Detail.find params[:id]
	end

	def update
		detail = Detail.find params[:id]
		detail.tv_station = params[:detail][:tv_station]
		detail.started_at = params[:detail][:started_at]
		detail.save
		redirect_to :back
	end
end
