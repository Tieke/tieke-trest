class Post < ActiveRecord::Base
	belongs_to :user

  # validates :img_url, :url => true
end
