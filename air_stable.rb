require 'sinatra'
require_relative 'models'
enable :sessions

get "/" do
  #test
  @user = User.get(session[:user_id])
  erb :home #Fancy I can specify, { :layout => :default_layout}
end

get "/users/new" do
  @user = User.new
  erb :new_user
end

post "/users/new" do
  @user = User.create(params[:user])
  if @user.saved?
    redirect "/"
  else
    erb :new_user
  end
end

get "/users/login" do
  #confused crashing with no input
  #not showing errors yet.
  @errors = session[:login_errors]
  session.delete(:login_errors)

  erb :home
end

post "/users/login" do
  email = params[:user]["email"]
  password = params[:user]["password"]

  user = User.first(:email => email)

  if user.password == password
    session[:user_id] = user.id
    redirect "/"
  else
    session[:login_errors] = 'Access Denied!'
    redirect '/users/login'
  end
end

get "/users/logout" do
  #Both logout's are working curious on pro's con's
  session.clear
  redirect "/"
end

delete "/users/logout" do
  #Needed form working
  session.delete(:user_id)
  redirect "/"
end
