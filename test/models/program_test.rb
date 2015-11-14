require 'test_helper'

class ProgramTest < ActiveSupport::TestCase
	test "update from valid json" do
		json = File.read("test/fixtures/valid_program.json")
		program = Program.update_from_json(json)
		data = JSON.parse(json)
		assert_equal data["title"], program.title
	end

	test "when Program's Details have WatchList, vote method should return number of its WatchLists" do
		p = Program.create
		d = p.details.create
		d.watch_lists.create(:user_id => 1)
		d.watch_lists.create(:user_id => 1)
		d.watch_lists.create(:user_id => 1)
		d.watch_lists.create(:user_id => 1)
		assert_equal 4, p.vote
	end

  test "get earliest_date" do
    p = Program.create

    date = []
    date.push(DateTime.new(2015, 1, 1, 12, 0, 0))
    date.push(DateTime.new(2015, 1, 2, 12, 0, 0))
    date.push(nil)
    date.push(DateTime.new(2015, 1, 1, 13, 0, 0))

    date.each do |d|
      p.details.create(:started_at => d)
    end

    assert_equal date[0], p.earliest_date
  end
end
