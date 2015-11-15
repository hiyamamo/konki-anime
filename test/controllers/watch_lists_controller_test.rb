require 'test_helper'

class WatchListsControllerTest < ActionController::TestCase
	def setup
		@user = users(:one)
		sign_in @user
	end


  test 'create with new detail' do
		season = Season.find_by_current(true)
		program = season.programs.create(:title => "title")
    d = program.details.create

    detail_id = d.id

    post :create, { :user_name => @user.name, :detail_id => detail_id }
    assert_equal 1, @user.watch_lists.count, "watch_lists count"

    assert_equal 1, Program.find_by_id(program.id).vote, "vote"

  end

  test 'delete existing detail' do
		season = Season.find_by_current(true)
    program = season.programs.create(:vote => 2)
    d = program.details.create

    delete :destroy, { :user_name => @user.name, :detail_id => d.id }

    assert_equal 1, Program.find_by_id(program.id).vote
    assert_not @user.watch_lists.find_by_detail_id(d.id)
  end
end
