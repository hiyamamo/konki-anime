require 'open-uri'
require 'json'
require 'date'

module WatchListsHelper
	def parse_time(start_time)
		start_time.strftime("%m月%d日 %H:%M")
	end

	def build_options(details)
		results = {}
		details.each do |detail|
			time = parse_time detail["started_at"]
			disp = "#{detail['tv_station']} : #{time}"
			results[disp] = detail.id
		end
		results
	end
end
