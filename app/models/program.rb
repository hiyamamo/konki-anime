require 'csv'
class Program < ActiveRecord::Base
	has_many :details, dependent: :destroy
  belongs_to :season
	attr_accessor :rank

  def self.update_from_json(json)
		val = JSON.parse json
    program = find(val['id'])
    program.title = val['title']
    program.url = val['url']
    program.save
    val['details'].each do |d|
      detail = Detail.find(d['id'])
      detail.tv_station = d['tv_station']
      detail.started_at = d['started_at']
      detail.save
    end
    program
  end

  def self.insert_from_json(json)
    val = JSON.parse json
    season_value = val["season"]
    season = Season.where("value = ?", season_value).first || Season.create(:value => season_value)
    programs = val["programs"]
    programs.each do |program|
      p = season.programs.create(title: program["title"], url: program["url"])
      details = program["details"]
      if details.empty?
        p.details.create(tv_station: "none", started_at: "")
      else
        details.each do |detail|
          started_at = Chronic.parse detail["started_at"]
          p.details.create(tv_station: detail["station"], started_at: started_at)
        end
      end
      p.save!
    end
  end


  def self.new_from_json(json, season)
		val = JSON.parse json
    program = where("title = #{val['title']}").first
    if program.nil?
      program = create(title: val['title'], url: val['url'], season: season)
    end
    details = val['details']
    program.details.create(tv_station: details['tv_station'], started_at: details['started_at'])

    program.save
  end

	def vote
		vote = 0
		self.details.each do |detail|
			vote += detail.watch_lists.count
		end
		vote
	end

  def earliest_date
    self.details.order('started_at IS NULL, started_at ASC').first.started_at
  end

end
