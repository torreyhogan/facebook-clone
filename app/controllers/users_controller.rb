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
    # redirect_to root_url and return unless @user.activated
    if @user == current_user
      @friend_requests_received = FriendRequest.where(receiver_id: @user.id)
      @friend_requests_sent = FriendRequest.where(sender_id: @user.id)
      
    end
    @friends = @user.friends
    @posts = @user.posts.sort_by{|x| x.created_at }.reverse
  end

  def index
    @users = User.where(activated: true).where.not(id: current_user.id)
    @friends = current_user.friends 
    @requests_sent = current_user.sent_friend_requests.map { |x| x.receiver}
    @requests_received = current_user.received_friend_requests.map { |x| x.sender }
  end



  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
