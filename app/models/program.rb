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
    season = Season.where("value = ?", season_value).first || Season.create(:value => season_str)
    programs = val["programs"]
    programs.each do |program|
      p = self.create(title: program["title"], url: program["url"])
      details = program["details"]
      details.each do |detail|
        p.details.create(tv_station: detail["tv_station"], started_at: detail["started_at"])
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

end
