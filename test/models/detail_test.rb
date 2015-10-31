require 'test_helper'

class DetailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

	test "wday" do
		detail = Detail.create
		day = Time.gm(2015, 10, 31, 0, 0, 0)
		detail.started_at = day
		assert_equal :sat, detail.wday

	end
end
