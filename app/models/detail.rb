class Detail < ActiveRecord::Base
  belongs_to :program
	delegate :season, to: :program
	has_many :watch_lists
	has_many :users, :through => :watch_lists
end
