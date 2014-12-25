require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:peter)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]",  signup_path
    # logout link is not showing
    assert_select "a[href=?]",  logout_path, count: 0
    get signup_path
    assert_select "title", full_title("Sign up")
    # assert dropdown is not present
    assert_select "ul[class=?]", "dropdown-menu", false
  end

  test "layout links while logged in" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]",  signup_path
    # logout link appears logged in
    assert_select "a[href=?]",  logout_path
    # assert dropdown is present
    assert_select "ul[class=?]", "dropdown-menu"
  end
end
