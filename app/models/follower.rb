class Follower < ActiveRecord::Base
	has_many :user_followers
	has_many :users, through: :user_followers
end
