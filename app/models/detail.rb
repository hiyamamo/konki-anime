class Detail < ActiveRecord::Base
  belongs_to :program
	delegate :season, to: :program
	has_many :watch_lists
	has_many :users, :through => :watch_lists

	def wday
		wdays = [:sun, :mon, :tue, :wen, :thu, :fri, :sat]
    if started_at.blank?
      :other
    else
      wdays[started_at.wday]
    end
	end
end
