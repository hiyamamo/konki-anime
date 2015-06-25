require 'test_helper'

class ProgramTest < ActiveSupport::TestCase
	test "update from valid json" do
		json = File.read("test/fixtures/valid_program.json")
		program = Program.update_from_json(json)
		data = JSON.parse(json)
		assert_equal data["title"], program.title
	end
end
