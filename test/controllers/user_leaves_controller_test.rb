require 'test_helper'

class UserLeavesControllerTest < ActionController::TestCase
  setup do
    @user_leave = user_leaves(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_leaves)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_leave" do
    assert_difference('UserLeave.count') do
      post :create, user_leave: { leave_id: @user_leave.leave_id, leave_left: @user_leave.leave_left, leave_taken: @user_leave.leave_taken, user_id: @user_leave.user_id }
    end

    assert_redirected_to user_leave_path(assigns(:user_leave))
  end

  test "should show user_leave" do
    get :show, id: @user_leave
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_leave
    assert_response :success
  end

  test "should update user_leave" do
    patch :update, id: @user_leave, user_leave: { leave_id: @user_leave.leave_id, leave_left: @user_leave.leave_left, leave_taken: @user_leave.leave_taken, user_id: @user_leave.user_id }
    assert_redirected_to user_leave_path(assigns(:user_leave))
  end

  test "should destroy user_leave" do
    assert_difference('UserLeave.count', -1) do
      delete :destroy, id: @user_leave
    end

    assert_redirected_to user_leaves_path
  end
end
