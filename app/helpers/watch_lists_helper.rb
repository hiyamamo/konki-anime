require 'open-uri'
require 'json'
require 'date'

module WatchListsHelper
	def build_options(details)
		results = {}
		details.each do |detail|
			time = strftime detail["started_at"]
			disp = "#{detail['tv_station']} : #{time}"
			results[disp] = detail.id
		end
		results
	end
end
