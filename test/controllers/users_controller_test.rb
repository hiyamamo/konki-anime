require 'test_helper'

class UsersControllerTest < ActionController::TestCase
	test 'show' do
		user = users(:one)
		get :show, { :user_name => user.name }
		assert_response :success
	end

end
