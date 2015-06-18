require 'faker'
require 'factory_girl'

20.times {FactoryGirl.create(:user)}

def sampled_follower_id_minus_user(user)
  users_minus_user = User.all - User.where(id: user.id)
  users_minus_user.sample.id
end

def random_num_of_followers(user)
  rand(3..20).times {user.followers << FactoryGirl.create(:follower, user_follower_id: sampled_follower_id_minus_user(user))}
end

def random_num_of_posts(user)
  rand(1..10).times {user.followers << FactoryGirl.create(:follower)}
end

User.all.each do |user|
  random_num_of_followers(user)
  random_num_of_posts(user)
end