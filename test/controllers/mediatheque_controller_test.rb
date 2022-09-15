require 'test_helper'

class MediathequeControllerTest < ActionDispatch::IntegrationTest
  test "should get photo" do
    get mediatheque_photo_url
    assert_response :success
  end

  test "should get video" do
    get mediatheque_video_url
    assert_response :success
  end

  test "should get photocat" do
    get mediatheque_photocat_url
    assert_response :success
  end

  test "should get videocat" do
    get mediatheque_videocat_url
    assert_response :success
  end

end
