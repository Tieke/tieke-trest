class CreateUserFollowers < ActiveRecord::Migration
  def change
  	create_table :user_followers do |t|
  		t.belongs_to :user, index: true
  		t.belongs_to :follower, index: true
  		t.timestamps null: false
  	end
  end
end
