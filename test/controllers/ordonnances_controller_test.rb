require "test_helper"

class OrdonnancesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get ordonnances_show_url
    assert_response :success
  end

  test "should get new" do
    get ordonnances_new_url
    assert_response :success
  end

  test "should get create" do
    get ordonnances_create_url
    assert_response :success
  end

  test "should get edit" do
    get ordonnances_edit_url
    assert_response :success
  end

  test "should get update" do
    get ordonnances_update_url
    assert_response :success
  end
end
