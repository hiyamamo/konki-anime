require 'test_helper'

class WatchListTest < ActiveSupport::TestCase
	def setup
		@user = User.create
		@datetime = DateTime.new(2015, 7, 1, 2, 0, 0)
		@season = '2015-7'
	end
	test 'should not save watch_list without user_id' do
		watch_list = WatchList.new
		assert_not watch_list.save, 'Saved the watch_list without a user_id'
	end

	test 'create from valid posted_data' do
		details = [
			{
				"program_id" => 1,
				"tv_station" => "aaa",
				"started_at" => @datetime.to_s
			},
			{
				"program_id" => 2,
				"tv_station" => "bbb",
				"started_at" => @datetime.next.to_s
			},
			{
				"program_id" => 3,
				"tv_station" => "ccc",
				"started_at" => @datetime.next.next.to_s
			}
		]

		programs = [
			{
				"id" => 1,
				"title" => "title1",
			},
			{
				"id" => 2,
				"title" => "title2",
			},
		]

		WatchList.create_from_posted_data(@user, details, programs, @season)

		assert_equal @user.watch_lists.count, 2
	end

	test 'create from invalid program_id' do
		details = [
			{
				"program_id" => 1,
				"tv_station" => "aaa",
				"started_at" => @datetime.to_s
			},
			{
				"program_id" => 2,
				"tv_station" => "bbb",
				"started_at" => @datetime.next.to_s
			},
			{
				"program_id" => 3,
				"tv_station" => "ccc",
				"started_at" => @datetime.next.next.to_s
			}
		]

		programs = [
			{
				"id" => 1,
				"title" => "title1",
			},
			{
				"id" => 100,
				"title" => "title2",
			},
		]
		WatchList.create_from_posted_data(@user, details, programs, @season)

		assert_equal @user.watch_lists.count, 0
	end

	test 'create from invalid started_at' do
		details = [
			{
				"program_id" => 1,
				"tv_station" => "aaa",
				"started_at" => @datetime.to_s
			},
			{
				"program_id" => 2,
				"tv_station" => "bbb",
				"started_at" => "aaaa"
			},
		]

		programs = [
			{
				"id" => 1,
				"title" => "title1",
			},
			{
				"id" => 2,
				"title" => "title2",
			},
		]
		WatchList.create_from_posted_data(@user, details, programs, @season)

		assert_equal @user.watch_lists.count, 0
	end

end
