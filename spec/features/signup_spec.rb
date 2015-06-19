require 'spec_helper'

describe "the sign up process", feature: true do
  let(:user) {build(:user, password:"password")}

  it "signs up a user" do
    visit '/'
    within('#secondary') do
      fill_in "handle", with: user.handle
      fill_in "email", with: user.email
      fill_in "password", with: "password"
    end
    click_button 'Create Account'
    expect(page).to have_content 'Profile:'
  end
end