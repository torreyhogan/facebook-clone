class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Account Created"
      redirect_to @user 
    else
      flash[:failure] = "Error, couldn't create account"
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all 
  end



  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
