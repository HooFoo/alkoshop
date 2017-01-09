require 'test_helper'

class SupportControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get support_add_url
    assert_response :success
  end

end
