require 'open-uri'
require 'json'
require 'date'

module WatchListsHelper
	def build_options(details)
		results = {}
    details = sort_details_by_started_at(details)

		details.each do |detail|
			time = strftime detail["started_at"]
			disp = "#{detail['tv_station']} : #{time}"
			results[disp] = detail.id
		end
		results
	end

  def sort_details_by_started_at(details)
    details.order('started_at IS NULL, started_at ASC')
  end

end
