class User < ActiveRecord::Base
	has_many :watch_lists, dependent: :destroy
	has_many :details, :through => :watch_lists
	validates :name, :presence => true
	validates :access_token, :presence => true
	validates :access_token_secret, :presence => true
	before_create :create_remember_token

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

	def update_access_token(auth)
		self.access_token = auth["credentials"]["token"]
		self.access_token_secret = auth["credentials"]["secret"]
		save
	end

	def watch_lists_program_ids(season)
		ids = []
		watch_lists.where(season: season).each do |w|
			ids.push w.program_id
		end
	end

	def User.new_rememnber_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private
		def create_remember_token
			self.remember_token = User.encrypt(User.new_rememnber_token)
		end

end
