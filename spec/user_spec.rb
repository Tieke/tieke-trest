require 'spec_helper'

describe "User" do
  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end

  it "is invalid without a valid email" do
    expect(FactoryGirl.build(:user, email: nil)).to_not be_valid
  end

  it "is invalid without a handle" do
    expect(FactoryGirl.build(:user, handle: nil)).to_not be_valid
  end

  it "is invalid without a valid password" do
     expect(FactoryGirl.build(:user, password: nil)).to_not be_valid
  end

  it "#authenticate correct password" do
    user = create(:user, password: "password")
    expect(User.authenticate(user.handle, "password")).to eq(user)
  end

  it "doesn't #authenticate an invalid password" do
    user = create(:user, password: "password")
    expect(User.authenticate(user.handle, "schlerp")).to be_nil
  end
end
