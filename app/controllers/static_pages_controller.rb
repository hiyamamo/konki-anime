class StaticPagesController < ApplicationController
	def home
		idx = params[:season]
		@season = Season.new(idx)
	end
end
