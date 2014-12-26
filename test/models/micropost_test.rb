require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:peter)
    @micropost = @user.microposts.build(content: "foo bar")
  end

  test "micropost should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "micropost longer than 140 chars is invalid" do
    @micropost.update_attribute(:content, "a" * 141)
    assert_not @micropost.valid?
  end

  test "microsoft less than or equal to 140 chars is valid" do
    @micropost.update_attribute(:content, "aaa")
    assert @micropost.valid?
  end

  test "micropost with no content is invalid" do
    @micropost.update_attribute(:content, "     ")
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    assert_equal Micropost.first, microposts(:most_recent)
  end
end
