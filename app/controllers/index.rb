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
  if session[:user]
    @user = session[:user]
    @user_follows = Follower.where(user_id: @user.id)
    @user_following = UserFollower.where(follower_id: @user_follows.first.id)
    @users = User.where(id: @user_following)
    @posts = @users.posts
    erb :posts
  else
    invalid_session
  end
end

# Display the new post form
get '/posts/new' do
  if session[:user]
    erb :new_post
  else
    invalid_session
  end
end

# Submitting the new post
post '/posts' do
  if session[:user]
    redirect '/posts'
  else
    invalid_session
  end
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
  if session[:user]
    erb :show_user
  else
    invalid_session
  end
end

# Display list of your followers
get '/followers' do
  if session[:user]
    erb :followers
  else
    invalid_session
  end
end

# Follow someone
post '/followers' do
  if session[:user]
    redirect '/followers'
  else
    invalid_session
  end
end

# Login
post '/login' do
  if @user = User.authenticate(params[:handle], params[:password])
    session[:user] = @user
    redirect '/posts'
  else
    invalid_login
  end
end

# Logout
get '/logout' do
  session.clear
  redirect '/'
end


def invalid_login
  session[:error] = "Invalid user name or password"
  redirect '/'
end

def invalid_session
  session[:error] = "Sorry, you don't have permission to view that page."
  redirect '/'
end