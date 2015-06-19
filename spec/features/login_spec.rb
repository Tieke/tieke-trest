require 'spec_helper'

describe "the log in process", feature: true do
  let(:user) {create(:user, password:"password")}

  it "signs in a user" do
    visit '/'
    within('#primary') do
      fill_in "handle", with: user.handle
      fill_in "password", with: "password"
    end
    click_button 'Log in'
    expect(page).to have_content 'Recent posts from people you follow:'
  end
end
