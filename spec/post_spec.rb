require 'spec_helper'

describe "Post" do
  it "has a valid factory" do
    expect(create(:post)).to be_valid
  end

  it "can be assigned to a user" do
    user = create(:user)
    post = create(:post)
    user.posts << post
    expect(post.user_id).to be_truthy
  end
end
