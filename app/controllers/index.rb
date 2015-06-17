# Login / Sign Up
get '/' do
  erb :index
end

# Posts of followers
get '/posts' do
  erb :posts
end

# Display the new post form
get '/posts/new' do
  erb :new_post
end

# Submitting the new post
post '/posts' do
  redirect '/posts'
end

# Display user profile
get '/users/:id' do
  erb :show_user
end

# Display list of your followers
get '/followers' do
  erb :followers
end

# Follow someone
post '/followers' do
  redirect '/followers'
end