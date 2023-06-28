require "test_helper"

class Public::CaartsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_caarts_index_url
    assert_response :success
  end
end
