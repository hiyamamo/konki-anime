class Detail < ActiveRecord::Base
  belongs_to :program
	delegate :season, to: :program
	has_many :watch_lists
	has_many :users, :through => :watch_lists

	def wday
		wdays = [ "日", "月", "火", "水", "木", "金", "土", ]
		wdays[started_at.wday]
	end
end
