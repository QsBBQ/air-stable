require 'sinatra'
require_relative 'config/dotenv'
require_relative 'config/session'
require_relative 'models'




#enable :sessions


helpers do
  def login(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !session[:user_id].nil?
  end

  def current_user
    @current_user ||=User.get(session[:user_id])
  end

  def ensure_logged_in!
    unless logged_in?
      halt 403, "You must be logged in to do that!"
    end
  end
end

get "/" do
  @stalls = Stall.all
  erb :home
end

get "/stalls/new" do
  if logged_in?
    @stall = current_user.stalls.new
    erb :new_stall
  else
    redirect "/"
  end
end

post "/stalls/new" do
  ensure_logged_in!
  @stall = current_user.stalls.create(params["stall"])
  if @stall.saved?
    redirect "/"
  else
    erb :new_stall
  end
end

get "/stalls/:stall_id" do
  stall_id = params[:stall_id]
  @stall = Stall.get(stall_id)
  @user = User.get(@stall.creator_id)

  erb :show_stall
end

get "/user/dashboard" do
  erb :user_dashboard
end

get "/users/new" do
  @user = User.new
  erb :new_user
end

post "/users/new" do
  @user = User.new(params[:user])
  @user.save
  if @user.saved?
    login(@user)
    redirect "/"
  else
    erb :new_user
  end
end

get "/users/login" do
  @errors = session[:login_errors]
  session.delete(:login_errors)

  erb :home
end

post "/users/login" do
  email = params[:user]["email"]
  password = params[:user]["password"]

  user = User.first(:email => email)

  if user && user.password == password
    #session[:user_id] = user.id
    login(user)
    redirect "/"
  else
    session[:login_errors] = 'Access Denied!'
    redirect '/users/login'
  end
end

get "/users/logout" do
  #Both logout's are working
  session.clear
  redirect "/"
end

delete "/users/logout" do
  session.delete(:user_id)
  redirect "/"
end
