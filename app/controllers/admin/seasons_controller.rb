class Admin::SeasonsController < ApplicationController
	def index
		@seasons = Season.all
	end

	def destroy
		season = Season.find(params[:id])
		season.destroy
		redirect_to admin_seasons_path
	end
end
