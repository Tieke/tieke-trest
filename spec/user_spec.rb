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
    user = create(:user)
    expect(User.authenticate(user.handle, user.password)).to eq(user)
  end

  xit "doesn't authenticate an invalid password"
end
