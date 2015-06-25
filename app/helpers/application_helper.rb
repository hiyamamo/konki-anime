require 'open-uri'
require 'json'
module ApplicationHelper
	def programs(season, sort = nil)
		season.programs_with_rank(sort)
	end

	# ページ毎のタイトルを返す
	def full_title(title)
		base_title = "今期アニメ"
		if title.empty?
			base_title
		else
			"#{base_title} | #{title}"
		end
	end

	def current_season_to_api_fmt
		Season.new.to_api_fmt
	end

	def current_season
		Season.new.now
	end
end
