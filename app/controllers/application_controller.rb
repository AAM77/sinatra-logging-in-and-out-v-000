require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/signup' do
    # @user = User.create(params)
    @user = User.new(params)

    if @user.save
      # success, redirect to user show
    else
      # include an error message here
      # re-render the sing up form 
      # or, redirect back to sign up
    end 
  end

  patch '/users/:id' do
    @user = User.find_by(params[:id])

    if @user.update(params)
      # success, redirect to user show
    else
      # include an error message here
      # re-render the sing up form 
      # or, redirect back to edit form
    end 
  end
  

  post '/login' do
    @user = User.find_by(username: params[:username])
    if !@user.nil? && @user.password == params[:password]
      session[:user_id]=@user.id
      redirect '/account'
    else
      erb :error
    end
  end

  get '/account' do
    @current_user = User.find_by_id(session[:user_id])
    if @current_user
      erb :account
    else
      erb :error
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end


end
