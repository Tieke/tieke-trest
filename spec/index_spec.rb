require 'spec_helper'

describe 'IndexController' do

let (:rack_session) { {'rack.session' => { :user_id => create(:user).id } } }

let (:valid_user) {create(:user)}

let (:valid_follower) {create(:follower, user_follower_id: 10)}

  describe "GET '/'" do
    it "returns http status code 200" do
      get '/'
      expect(last_response.status).to eq(200)
    end
  end

  describe "GET '/posts'" do
    it "returns http status code 200" do
      get '/posts', {} , rack_session
      expect(last_response.status).to eq(200)
    end
  end

  describe "GET '/posts/new'" do
    it "returns http status code 200" do
      get '/posts/new', {} , rack_session
      expect(last_response.status).to eq(200)
    end
  end

  describe "POST '/posts'" do
    it "returns http status code 302" do
      post '/posts', {} , rack_session
      expect(last_response.status).to eq(302)
    end
  end

  describe "POST '/users'" do
    it "returns http status code 302" do
      user = FactoryGirl.build(:user)
      post '/users', user.attributes
      expect(last_response.status).to eq(302)
    end
  end

  describe "GET '/users/:id'" do
    it "returns http status code 200" do
      user = valid_user
      get "/users/#{user.id}", {} , rack_session
      expect(last_response.status).to eq(200)
    end
  end

  describe "GET '/followers'" do
    it "returns http status code 200" do
      get '/followers', {} , rack_session
      expect(last_response.status).to eq(200)
    end
  end

  describe "POST '/followers/new'" do
    it "returns http status code 302" do
      follower = valid_follower
      user = valid_user
      user.followers << follower
      post '/followers/new', {id: follower.id} , rack_session
      expect(last_response.status).to eq(302)
    end
  end
end
