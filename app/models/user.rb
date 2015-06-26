class User < ActiveRecord::Base
	has_many :watch_lists, dependent: :destroy
	has_many :details, :through => :watch_lists

	def self.create_with_auth(auth)
		create!do |user|
			user.provider = auth["provider"]
			user.uid = auth["uid"]
			user.name = auth["info"]["nickname"]
			user.screen_name = auth["info"]["name"]
			user.access_token = auth["credentials"]["token"]
			user.access_token_secret = auth["credentials"]["secret"]
			user.img_url = auth["info"]["image"]
		end
	end

	def watch_lists_program_ids(season)
		ids = []
		watch_lists.where(season: season).each do |w|
			ids.push w.program_id
		end
	end

end
