require 'test_helper'

class MenusControllerTest < ActionController::TestCase
  test "should get title:string" do
    get :title:string
    assert_response :success
  end

  test "should get data:string" do
    get :data:string
    assert_response :success
  end

end
