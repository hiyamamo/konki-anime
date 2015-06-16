require 'test_helper'

class WatchListsControllerTest < ActionController::TestCase
	def setup
		@user = users(:one)
		@user.watch_lists.create(:season => '2015-07')
	end
	test 'shold get new' do
		get :new, {}, { :user_id => @user.id }
		assert_response :success
	end

	test 'get show' do
		get :show, {:season => '2015-07'}, { :user_id => @user.id }
		assert_response :success
		assert_not_empty assigns(:watch_lists)
		assert_equal assigns(:season), '2015年07月期'
	end

	test 'get show invalid season' do
		get :show, {:season => 'invalid'}, { :user_id => @user.id }
		assert_redirected_to "users/#{@user.id}"
	end

	test 'get new should redirect_to root if user not login' do
		get :new
		assert_redirected_to root_path, "get new not redirected to root"
	end

	test 'get show should redirect_to root if user not login' do
		get :show, :season => '2015-7'
		assert_redirected_to root_path
	end

	test 'post create should redirect_to root if user not login' do
		get :create
		assert_redirected_to root_path
	end
end
