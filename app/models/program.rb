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
		program.vote = val['vote']
    program.save
    val['details'].each do |d|
      detail = Detail.find(d['id'])
      detail.tv_station = d['tv_station']
      detail.started_at = d['started_at']
      detail.save
    end
    program
  end

  # csv一行分をインサートする
  def self.insert_from_csv(csv)
		season_str = ""
		CSV.foreach(csv) do |row|
			if row[0] == "season"
				season_str = row[1]
			else
				title = row[0]
				program = where("title = ?", title).first
				if program.nil?
					program = create(title: title, url: row[1])
					season = Season.where("value = ?", season_str).first || Season.create(:value => season_str)
					program.season = season
				end
				program.details.create(tv_station: row[2], started_at: row[3])
				program.save!
			end
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

end
