require 'test_helper'

class PageControllerTest < ActionDispatch::IntegrationTest
  test "should get site" do
    get page_site_url
    assert_response :success
  end

end
