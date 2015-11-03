require 'json'
class WatchListsController < ApplicationController
	include SessionsHelper

	def index
		@user = User.find_by_name(params[:user_name])
		@season = Season.find_by_value(params[:season])
		details = Detail.where(:program => Program.where(:season => @season))
		@watch_lists = @user.watch_lists.where(:detail => details)
	end

	def new
		@season = Season.current
    @programs = Program.where(:season => @season)
	end

	def create
		user = User.find_by_name(params[:user_name])
		detail_ids = params[:selection]

    watch_lists = user.watch_lists(Season.current)

    unless detail_ids.blank?
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
      watch_lists.each do |watch_list|
        unless detail_ids.include? watch_list.detail_id
          watch_list.destroy
        end
      end
    else
      watch_lists.destroy_all
    end
		redirect_to user_path(:name => user.name)
	end

end
