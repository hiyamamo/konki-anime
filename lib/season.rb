class Season
	attr_accessor :idx
	def initialize(idx=nil)
		@list = seasons

		if idx.nil?
			@idx = now_idx @list
		else
			@idx = idx.to_i
		end
	end

	def now
		get_string @idx
	end

	def next?
		idx = @idx + 1
		idx < @list.length && idx >= 0
	end

	def next
		idx = @idx + 1
		get_string idx
	end

	def next_url
		idx = @idx + 1
		get_url idx
	end

	def prev?
		idx = @idx - 1
		idx < @list.length && idx >= 0
	end

	def prev
		idx = @idx - 1
		get_string idx
	end

	def prev_url
		idx = @idx - 1
		get_url idx
	end

	def to_api_fmt
		if @idx >= @list.length || idx < 0
			'all'
		else
			@list[@idx].strftime("%Y-%m")
		end
	end

	private
	def seasons
		url = "http://konki-anime.herokuapp.com/json/seasons"
		res = open(url);
		code, message = res.status
		if code == '200'
			seasons = JSON.parse res.read
			format = '%Y-%m'
			seasons_date = seasons.map do |s|
				DateTime.strptime s, format
			end
			seasons_date.sort!
		else
			nil
		end
	end

	def now_idx(seasons)
		today = Date.today
		idx = seasons.index do |season|
			season >= today
		end
		idx
	end

	def get_string(idx)
		if idx >= @list.length || idx < 0
			"-"
		else
			@list[idx].strftime("%Y年%m月期")
		end
	end

	def get_url(idx)
		"/home/#{idx}"
	end
end

