class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email 
      flash[:info] = "Please check your email to activate your account"
      redirect_to users_path
    else
      flash[:danger] = "Error, couldn't create account"
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated
  end

  def index
    @users = User.where(activated: true)
  end



  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
