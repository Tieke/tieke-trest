require 'spec_helper'

describe 'IndexController' do
  describe "GET '/'" do
    it "returns http status code 200" do
      get '/'
      expect(last_response.status).to eq(200)
    end
  end

  describe "GET '/posts'" do
    it "returns http status code 200" do
      get '/posts'
      expect(last_response.status).to eq(200)
    end
  end

  describe "GET '/posts/new'" do
    it "returns http status code 200" do
      get '/posts/new'
      expect(last_response.status).to eq(200)
    end
  end

  describe "POST '/posts'" do
    it "returns http status code 302" do
      post '/posts'
      expect(last_response.status).to eq(302)
    end
  end

  describe "POST '/users'" do
    it "returns http status code 302" do
      post '/users'
      expect(last_response.status).to eq(302)
    end
  end

  describe "GET '/users/:id'" do
    it "returns http status code 200" do
      get '/users/:id'
      expect(last_response.status).to eq(200)
    end
  end

  describe "GET '/followers'" do
    it "returns http status code 200" do
      get '/followers'
      expect(last_response.status).to eq(200)
    end
  end

  describe "POST '/followers'" do
    it "returns http status code 302" do
      post '/followers'
      expect(last_response.status).to eq(302)
    end
  end
end
