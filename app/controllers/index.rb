require 'scrypt'

enable :sessions

# Login / Sign Up
get '/' do
  @errors = session[:error]
  session[:error] = nil
  erb :index
end

# Posts of people you follow
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

# Submitting the new user route
post '/users' do
  @user = User.create(handle: params[:handle], email: params[:email], password: params[:password])
  if User.authenticate(params[:handle], params[:password])
    session[:user] = @user
    redirect '/users/:id'
  else
    redirect '/'
  end
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

# Login
post '/login' do
  if @user = User.authenticate(params[:handle], params[:password])
    session[:user] = @user
    redirect '/posts'
  else
    session[:error] = "Invalid user name or password"
    redirect '/'
  end
end

# Logout
get '/logout' do
  session.clear
  redirect '/'
end