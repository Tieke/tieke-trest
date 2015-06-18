require 'spec_helper'

describe "UserFollower" do
  it "Join Table has a valid record joining users and followers" do
    user = create(:user)
    follower = create(:follower)
    user.followers << follower
    expect(UserFollower.find_by_user_id(user.id)).to be_truthy
  end
end
