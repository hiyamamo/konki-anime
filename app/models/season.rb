class Season < ActiveRecord::Base
	include ActiveModel::Validations
	validates_with SeasonValidator

	has_many :programs, :dependent => :destroy
	has_many :details, :through => :programs

	def programs_with_rank(sort = nil)
		programs = self.programs
		if sort == "vote"
			programs = programs.sort { |a, b| b.vote <=> a.vote }
		end
		temp_vote = 0
		offset = 0
		rank = 0
		result = programs.map do |p|
			if temp_vote != p.vote
				rank = rank + offset + 1
				offset = 0
				temp_vote = p.vote
			else
				offset += 1
			end
			p.rank = rank
			p
		end
		result
	end

	def now
		format self.value
	end

	def next
		@next = Season.where("value > ?", self.value).order("value DESC").first
		if @next.nil?
			nil
		else
			format @next.value
		end
	end

	def next_url
		if @next.nil?
			nil
		else
			get_url @next.value
		end
	end

	def prev
		@prev = Season.where("value < ?", self.value).order("value ASC").first
		if @prev.nil?
			nil
		else
			format @prev.value
		end
	end

	def prev_url
		if @prev.nil?
			nil
		else
			get_url @prev.value
		end
	end

	class << self
		def current
			find_by_current(true)
		end
	end

	private
		def format(value)
			v = value.split("-")
			"#{v[0]}年#{v[1]}月期"
		end

		def get_url(value)
			"/home/#{value}"
		end

end
