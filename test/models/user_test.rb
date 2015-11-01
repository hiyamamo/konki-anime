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

end
