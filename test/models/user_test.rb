require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = users(:one)
	end

	test 'when destroy User, associated WatchLists should be destroyed' do
		user = users(:one)
		watch_list = user.watch_lists.create
		user.destroy
		assert_not WatchList.exists?(watch_list)
	end

	test "attributes should exist" do
		assert @user.respond_to?(:uid), "uid"
		assert @user.respond_to?(:name), "name"
		assert @user.respond_to?(:img_url), "img_url"
		assert @user.respond_to?(:screen_name), "screen_name"
		assert @user.respond_to?(:access_token), "access_token"
		assert @user.respond_to?(:access_token_secret), "access_token_secret"
		assert @user.respond_to?(:provider), "provider"
		assert @user.respond_to?(:remember_token), "remember_token"
	end

	test "when name is not present" do
		@user.name = ""
		assert_not @user.valid?
	end

	test "when access_token is not present" do
		@user.access_token = ""
		assert_not @user.valid?
	end

	test "when access_token_secret is not present" do
		@user.access_token_secret = ""
		assert_not @user.valid?
	end

	test "remember token" do
		user = User.new(name: "name", access_token: "access_token",
						 access_token_secret: "access_token_secret")
		user.save
		assert_not_nil user.remember_token
	end


	test "watch_lists_at_wday" do
		sun_detail = details(:sunday)
		sat_detail = details(:saturday)
		program = Program.create

		program.season = Season.current
		sun_detail.program = program

		5.times do
			watch_list = WatchList.create
			watch_list.user = @user
			watch_list.detail = sun_detail
			watch_list.save
		end

		10.times do
			watch_list = WatchList.create
			watch_list.user = @user
			watch_list.detail = sat_detail
			watch_list.save
		end
		program = Program.create
		program.season = Season.current

		assert_equal 5, @user.watch_lists_at_wday(:sun, Season.current).count
		assert_equal 10, @user.watch_lists_at_wday(:sat).count

	end
end
