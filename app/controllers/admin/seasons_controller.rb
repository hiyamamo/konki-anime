class Admin::SeasonsController < ApplicationController
	def index
		@seasons = Season.all
	end

	def update
		season = Season.where(:current => true).first
		if season
			season.current = false
			season.save
		end
		season = Season.find(params[:id])
		season.current = true
		season.save
		redirect_to :back
	end

	def destroy
		season = Season.find(params[:id])
		season.destroy
		redirect_to admin_seasons_path
	end
end
