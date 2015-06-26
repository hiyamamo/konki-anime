class UsersController < ApplicationController
  def show
		@user = User.find_by_name(params[:user_name])
		@seasons = []
		@user.watch_lists.each do |w|
			@seasons.push w.detail.program.season
		end
		@seasons.uniq! { |season| season.value }
		@seasons.sort! { |a, b| a.value <=> b.value }
  end
end
