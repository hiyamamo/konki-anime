require 'test_helper'

class WatchListsControllerTest < ActionController::TestCase
	def setup
		@user = users(:one)
		sign_in @user
	end

	test 'create with all new id' do
		season = Season.find_by_current(true)
		program = season.programs.create
		program.details.create
		program.details.create
		program.details.create

		details = program.details

		selection = details.map do |d|
			d.id
		end
		post :create, { :user_name => @user.name, :selection => selection }
		assert_equal 3, @user.watch_lists.count, "all new id"

		selection = selection.drop(1)
		post :create, { :user_name => @user.name, :selection => selection }
		assert_equal 2, @user.watch_lists.count, "deleted exist id"

	end
end
