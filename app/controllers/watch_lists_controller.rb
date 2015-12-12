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
    @user = User.find_by_name(params[:user_name])
	end

	def create
		user = User.find_by_name(params[:user_name])
		detail_id = params[:detail_id]
    program = Detail.find_by_id(detail_id).program

    unless program.nil? || user.programs.include?(program)
      user.watch_lists.create(:detail_id => detail_id)
      program.vote = program.vote + 1
      program.save
    end
    head :ok
	end

  def destroy
    user = User.find_by_name(params[:user_name])
    detail_id = params[:detail_id]
    if wl = user.watch_lists.find_by_detail_id(detail_id)
      wl.destroy
    end

    program = Detail.find_by_id(detail_id).program

    program.vote -= 1

    if program.vote < 0
      program.vote = 0
    end
    program.save
    head :ok
  end

end
