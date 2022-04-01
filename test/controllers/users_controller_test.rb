require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: @user.email, gender: @user.gender, name: @user.name } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { email: @user.email, gender: @user.gender, name: @user.name } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end

  test "should search users" do
    User.create("name" => "unique_name", "title" => "unusual_title")
    get users_url, params: { search: "unique_name" }
    assert_response :success
    get users_url, params: { search: "unusual_title" }
    assert_response :success
  end

  test "should paginate users" do
    get users_url, params: { page: 2 }
    assert_response :success
  end

  test "should search users with pagination" do
    30.times do |i|
      User.create("name" => "unique_name_" + i.to_s , "title" => "unusual_title_" + i.to_s)
    end
    get users_url, params: { search: "unique_name", page: 2 }
    assert_response :success
    get users_url, params: { search: "unusual_title", page: 2 }
    assert_response :success
  end
  

end
