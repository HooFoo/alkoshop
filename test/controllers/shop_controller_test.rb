require 'test_helper'

class ShopControllerTest < ActionDispatch::IntegrationTest
  test "should get brands" do
    get shop_brands_url
    assert_response :success
  end

end
