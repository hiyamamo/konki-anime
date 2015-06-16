class UsersController < ApplicationController
  def show
		watch_lists = User.find(session[:user_id]).watch_lists.select(:season).uniq
		@seasons = watch_lists.map do |w|
			w.season
		end
  end
end
