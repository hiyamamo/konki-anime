class UsersController < ApplicationController
	before_action :signed_in_user
  def show
		@user = User.find_by_name(params[:user_name])
		season = Season.where(:current => true)
		@watch_lists = @user.watch_lists(season)
		@seasons = []
		@user.watch_lists.each do |w|
			@seasons.push w.detail.program.season
		end
		@seasons.uniq! { |season| season.value }
		@seasons.sort! { |a, b| a.value <=> b.value }
  end
	private
		def signed_in_user
			redirect_to root_path, notice: "Please sign in." unless singed_in?
		end
end
