require 'open-uri'
require 'json'
module ApplicationHelper
	def programs(season, sort = nil)
		if sort.nil?
			url = API_URL_PROGRAMS + season
		else
			url = API_URL_PROGRAMS + "#{season}?sort=#{sort}"
		end
		res = open(url);
		code, message = res.status
		if code == '200'
			src = JSON.parse res.read
			temp_vote = 0
			offset = 0
			rank = 0
			result = src.map do | s |
				if temp_vote != s["vote"]
					rank = rank + offset + 1
					offset = 0
					temp_vote = s["vote"]
				else
					offset += 1
				end
				s["rank"] = rank
				s
			end
			result
		else
			nil
		end
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
