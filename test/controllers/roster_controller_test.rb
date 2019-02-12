require 'test_helper'

class RosterControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get roster_index_url
    assert_response :success
  end

end
