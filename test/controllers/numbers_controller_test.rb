require "test_helper"

class NumbersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get numbers_index_url
    assert_response :success
  end

  test "should get create" do
    get numbers_create_url
    assert_response :success
  end
end
