require 'test_helper'

class NewsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get news_show_url
    assert_response :success
  end

  test "should get showcategory" do
    get news_showcategory_url
    assert_response :success
  end

end
