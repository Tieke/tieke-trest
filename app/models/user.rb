require 'scrypt'

class User < ActiveRecord::Base

	has_many :user_followers
  has_many :followers, through: :user_followers
	has_many :posts

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+{2,}\z/}
  validates :email, uniqueness: true, presence: true
  validates :handle, uniqueness: true, presence: true
  validates :password, length: { minimum: 5 }, presence: true

  before_create do
    self.password = SCrypt::Password.create(password)
  end

  def self.authenticate(handle, password)
    user = User.find_by(handle: handle)
    return user if user && SCrypt::Password.new(user.password) == password
    nil
  end

end

