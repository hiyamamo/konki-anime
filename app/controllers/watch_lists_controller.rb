require 'json'
class WatchListsController < ApplicationController
	include SessionsHelper
	before_action :signed_in_user
	def new
		@season = Season.where(:current => true).first
	end

	def show
		season = params[:season] || current_season_to_api_fmt
		@watch_lists = User.find(session[:user_id]).watch_lists.where(season: season)
		redirect_to "users/#{session[:user_id]}" if @watch_lists.empty?
		s = season.split('-')
		@season = "#{s[0]}年#{s[1]}月期"
	end

	def create
		user = User.find_by_name(params[:user_name])
		detail_ids = params[:selection]

		# 新規のみ追加
		detail_ids.each do |detail_id|
			if user.watch_lists.where(:detail_id => detail_id).empty?
				user.watch_lists.create(:detail_id => detail_id)
			end
		end
		# 既存のIDから無くなったものを削除
		detail_ids = detail_ids.map do |d|
			d.to_i
		end
		user.watch_lists.each do |watch_list|
			if watch_list.detail.season == Season.find_by_current(true)
				unless detail_ids.include? watch_list.detail_id
					watch_list.destroy
				end
			end
		end
		redirect_to user_path(:name => user.name)
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
