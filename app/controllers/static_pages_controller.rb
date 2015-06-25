class StaticPagesController < ApplicationController
	def home
		if params[:season].nil?
			@season = Season.where(:current => true).first || Season.last
		else
			@season = Season.where(:value => params[:season]).first
		end
	end
end
