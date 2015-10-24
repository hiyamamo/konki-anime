require 'test_helper'

class AuthentiactionTest < ActionDispatch::IntegrationTest
	test "for non-signed-in users" do
		user = users(:one)
		get "users/#{user.name}"
		assert_redirected_to root_url
	end
end
