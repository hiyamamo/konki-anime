require 'json'
class WatchListsController < ApplicationController
	include SessionsHelper
	before_action :signed_in_user
	def new
	end

	def show
		season = params[:season] || current_season_to_api_fmt
		@watch_lists = User.find(session[:user_id]).watch_lists.where(season: season)
		redirect_to "users/#{session[:user_id]}" if @watch_lists.empty?
		s = season.split('-')
		@season = "#{s[0]}年#{s[1]}月期"
	end

	def create
		user = User.find(session[:user_id])
		season = current_season_to_api_fmt
		old_ids = user.watch_lists_program_ids season
		user.watch_lists.destroy_all

		details = params["selection"].map do |p|
			JSON.parse p
		end
		programs = params[:checked][:programs].map do |p|
			JSON.parse p
		end
		WatchList.create_from_json_data user, details, programs
		new_ids = user.watch_lists_program_ids

		post_program_ids(new_ids, old_ids)
		redirect_to "/watch_lists/#{current_season_to_api_fmt}"
	end

	private
	def post_program_ids(new_ids, old_ids)
		inc_ids = new_ids - old_ids
		dec_ids = old_ids - new_ids

		program_ids = { :inc => inc_ids, :dec => dec_ids }

	end

	def signed_in_user
		redirect_to root_path, notice: "Please sign in." unless singed_in?
	end
end
