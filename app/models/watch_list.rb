class WatchList < ActiveRecord::Base
	belongs_to :user
	belongs_to :detail
	delegate :program, to: :detail
	validates :user_id, presence: true

	def self.create_from_posted_data(user, details, programs, season)
		transaction do
			programs.each do |p|
				begin
					detail = search_detail details, p["id"]
					watch_list = user.watch_lists.build(season: season)
					watch_list.title = p["title"]
					watch_list.program_id = p["id"]
					watch_list.tv_station = detail["tv_station"]
					watch_list.started_at = Date.parse detail["started_at"]

					watch_list.save!
				rescue
					raise ActiveRecord::Rollback
				end
			end
		end
	end

	private
	def self.search_detail(details, p_id)
		dt = details.index  do |d|
			d["program_id"] == p_id
		end
		details[dt]
	end

end
