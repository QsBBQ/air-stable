require 'sinatra'
require_relative 'models'

get "/" do
  erb :home, { :layout => :default_layout}
end

get "/users/new" do
  @user = User.new
  erb :new_user, { :layout => :default_layout }
end

post "/users/new" do
  @user = User.create(params[:user])
  if @user.saved?
    redirect "/"
  else
    erb :new_user, { :layout => :default_layout }
  end
end
