require 'test_helper'

class DirectActionsControllerTest < ActionController::TestCase
  setup do
    @direct_action = direct_actions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:direct_actions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create direct_action" do
    assert_difference('DirectAction.count') do
      post :create, direct_action: {  }
    end

    assert_redirected_to direct_action_path(assigns(:direct_action))
  end

  test "should show direct_action" do
    get :show, id: @direct_action
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @direct_action
    assert_response :success
  end

  test "should update direct_action" do
    patch :update, id: @direct_action, direct_action: {  }
    assert_redirected_to direct_action_path(assigns(:direct_action))
  end

  test "should destroy direct_action" do
    assert_difference('DirectAction.count', -1) do
      delete :destroy, id: @direct_action
    end

    assert_redirected_to direct_actions_path
  end
end
