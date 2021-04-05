class UsersController < ApplicationController

    before_action :require_logged_out, only: [:new, :create]
    before_action :require_logged_in, only: [:index]

    def index
        @users = User.all 
        render :index 
    end 

    def new
        @user = User.new 
        render :new 
    end 

    def create #signup
        @user = User.new(user_params)
        # debugger
        if @user.save
           login_user!(@user) 
           redirect_to user_url(@user)
        else 
            render :new
        end 
    end 

    def show
        @user = User.find(params[:id])

        render :show
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end 


end 