class User < ActiveRecord::Base
	has_many :user_followers
  has_many :followers, through: :user_followers
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+{2,}\z/}
  validates :email, uniqueness: true, presence: true
  validates :password, length: 5, presence: true
  def authenticate(password)
    return true if password == self.password
  end
end
