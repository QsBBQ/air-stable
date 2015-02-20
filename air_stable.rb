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
end

get "/" do
  @user = User.get(session[:user_id])
  erb :home
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
