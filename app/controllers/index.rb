require 'scrypt'

enable :sessions

def current_user
  @current_user ||= User.find_by(id: session[:user_id])
end

# Login / Sign Up
get '/' do
  @errors = session[:error]
  session[:error] = nil
  erb :index
end

# Posts of people you follow
get '/posts' do
  if @user = current_user
    user_follows = Follower.find_by(user_follower_id: current_user.id)
    user_following = UserFollower.where(follower_id: user_follows.id) if user_follows
    users = []
    user_following.each {|followee| users << User.find(followee.user_id)} if user_following
    @feed_array = []
    users.each { |user| @feed_array << user.posts.last(6) }
    @feed_array.compact!


    erb :posts
  else
    invalid_session
  end
end

# Display the new post form
get '/posts/new' do
  if current_user
    erb :new_post
  else
    invalid_session
  end
end

# Submitting the new post
post '/posts' do
  if current_user
    Post.create(user_id: current_user.id, img_url: params[:image], caption: params[:caption])
    redirect "/users/#{current_user.id}"
  else
    invalid_session
  end
end

# update a post
get '/posts/:id/edit' do
  @post = Post.find(params[:id])
  erb :edit_post
end

patch '/posts/:id' do
  if @user = current_user
    post = Post.find(params[:id])
    post.update(caption: params[:caption])
    redirect "/users/#{@user.id}"
  else
    invalid_session
  end
end


# delete a post
delete '/posts/:id' do
  if current_user
    post = Post.find(params[:id])
    post.destroy
    redirect "/users/#{session[:user_id]}"
  else
    invalid_session
  end
end

# Submitting the new user route
post '/users' do
  @user = User.new(handle: params[:handle], email: params[:email], password: params[:password])
  if @user.save && User.authenticate(params[:handle], params[:password])
    session[:user_id] = @user.id
    redirect "/users/#{current_user.id}"
  end
    session[:error] = "You've already signed up, please log in."
    redirect '/'
end

# Display user profile
get '/users/:id' do
  if current_user
    @user = User.find(params[:id])
    @posts = @user.posts
    @self = @user == current_user
    current_follower = Follower.find_by_user_follower_id(session[:user_id])
    @already_following = @user.followers.include?(current_follower)

    erb :show_user
  else
    invalid_session
  end
end

# Display list of your followers
get '/followers' do
  if current_user
    user_follows = Follower.find_by(user_follower_id: session[:user_id])
    user_following = UserFollower.where(follower_id: user_follows.id) if user_follows
    @users = []
    user_following.each {|followee| @users << User.find(followee.user_id)} if user_following
    @users.compact!
    follower_objects = User.find(session[:user_id]).followers
    @followers = follower_objects.map {|follower| User.find(follower.user_follower_id)}

    erb :followers
  else
    invalid_session
  end
end

# Follow someone
post '/followers/new' do
  if user = current_user
    follower = Follower.create(user_follower_id: user.id) unless follower = Follower.find_by_user_follower_id(user.id)
    UserFollower.create(user_id: params[:id], follower_id: follower.id)
    redirect '/posts'
  else
    invalid_session
  end
end

delete '/followers/remove' do
  if user = current_user
    follower = Follower.find_by(user_follower_id: user.id)
    UserFollower.where(user_id: params[:id], follower_id: follower.id).destroy_all
    redirect '/posts'
  else
    invalid_session
  end
end

# Login
post '/login' do
  puts params
  p User.authenticate(params[:handle], params[:password])
  if @user = User.authenticate(params[:handle], params[:password])
    session[:user_id] = @user.id
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

get '/search' do
  # @users = User.find_by_handle(params) || User.find_by_email(params)
  @users = User.where("handle = ? OR email = ?", params[:search], params[:search])
  erb :search
end


def invalid_login
  session[:error] = "Invalid user name or password"
  redirect '/'
end

def invalid_session
  session[:error] = "Sorry, you don't have permission to view that page."
  redirect '/'
end