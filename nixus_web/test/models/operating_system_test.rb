require 'test_helper'
require 'nixus_validation'

class OperatingSytemTest < ActiveSupport::TestCase
	test "cpe_name should be a valid CPE WFN" do
		os = operating_systems(:valid_x64)
		os.cpe_name = "invalid"
		assert_not os.valid?, "Operating System was considered valid even with an invalid CPE WFN as cpe_name"
	end

	test "Should only accept valid CPU architectures" do
		os = operating_systems(:valid_x64)
		os.cpu_architecture = "invalid"
		assert_not os.valid?, "Operating System was considered valid even with an invalid CPU architecture"
	end

	test "The valid sample fixture should be considered valid" do
		os = operating_systems(:valid_x64)
		assert os.valid?, "The valid sample fixture was not considered valid!"
	end

	test "CPU architecture should be converted to lower case when assigned" do
		os = operating_systems(:valid_x64)
		os.cpu_architecture = "ABC"
		assert os.cpu_architecture == "abc", "CPU architecture was not converted to lower case after assignment"
	end
end
