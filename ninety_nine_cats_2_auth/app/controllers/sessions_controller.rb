class SessionsController < ApplicationController

  before_action :require_logged_out, only: [:new, :create]
  before_action :require_logged_in, only: [:destroy]

  def new
    @user = User.new
    render :new
  end

  def create #login
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user
      login_user!(@user)
      redirect_to cats_url
    else
      render :new
    end
  end

  def destroy
    current_user.reset_session_token! if logged_in?
    session[:session_token] = nil 
    @current_user = nil 
    redirect_to new_session_url 
  end 

  

end