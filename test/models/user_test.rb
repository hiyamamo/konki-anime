require 'test_helper'

class UserTest < ActiveSupport::TestCase

	test 'when destroy User, associated WatchLists should be destroyed' do
		user = users(:one)
		watch_list = user.watch_lists.create
		user.destroy
		assert_not WatchList.exists?(watch_list)
	end

end
