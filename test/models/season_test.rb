require 'test_helper'

class SeasonTest < ActiveSupport::TestCase
	def setup
		@season = seasons(:two)
	end

	test "program_with_rank" do
		@season.programs.create(:vote => 2, :title => "a")
		@season.programs.create(:vote => 2, :title => "b")
		@season.programs.create(:vote => 1, :title => "c")
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
