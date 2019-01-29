class AccountActivationsController < ApplicationController
	skip_before_action :require_login

	def edit
		user = User.find_by(email: params[:email])
		if user && !user.activated? && user.authenticated?(:activation, params[:id])
			user.activate
			log_in user
			flash[:success] = "Accout activated!"
			redirect_to user 
		else
			flash[:danger] = "Invalid activation link"
			redirect_to root_url
		end
	end
end
