class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
      if user.activated?
    		log_in(user)
        remember user
    		redirect_to user
      else
        message = "Account not Activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
  	else
  		flash.now[:danger] = "unsuccessful login"
  		render 'new'
  	end
  end

  def destroy 
  	log_out if logged_in?
  	redirect_to users_path
  end
end
