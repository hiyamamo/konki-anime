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

end
