require 'faker'

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(6, 10) }
    handle { Faker::Internet.user_name}
  end
end