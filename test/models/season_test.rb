require 'test_helper'

class SeasonTest < ActiveSupport::TestCase
	def setup
		@season = seasons(:current)
	end

	test "program_with_rank" do
		a = @season.programs.create(:title => "a")
		b = @season.programs.create(:title => "b")
		c = @season.programs.create(:title => "c")
		d = a.details.create
		d.watch_lists.create(:user_id => 1)
		d = a.details.create
		d.watch_lists.create(:user_id => 1)
		d = b.details.create
		d.watch_lists.create(:user_id => 1)
		d = b.details.create
		d.watch_lists.create(:user_id => 1)
		d = c.details.create
		d.watch_lists.create(:user_id => 1)

		programs = @season.programs_with_rank("vote")
		p = programs[programs.index{|v| v.title == "a"}]
		assert_equal 1, p.rank
		p = programs[programs.index{|v| v.title == "c"}]
		assert_equal 3, p.rank

	end


	test "now" do
		assert_equal "2015年07月期", @season.now
	end

	test "prev" do
		assert_equal "2015年04月期", @season.prev
	end

	test "next" do
		assert_equal "2015年10月期", @season.next
	end

	test "current" do
		assert_equal "2015-07", Season.current
	end

	test "should not save season when two season which current is ture" do
		season = Season.new(:value => "2016-01", :current => true)
		assert_not season.save
	end

end
