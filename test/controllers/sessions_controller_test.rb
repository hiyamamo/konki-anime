require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
	def setup
		@user = users(:one)
	end

	test "sign out" do
		sign_in @user
		post :destroy
		assert_nil cookies[:remember_token]
	end

end
