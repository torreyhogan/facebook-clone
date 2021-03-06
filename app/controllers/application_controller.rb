class ApplicationController < ActionController::Base
	protect_from_forgery
	include SessionsHelper
	before_action :require_login

	private

	def require_login
		unless logged_in?
			flash[:error] = "You must be logged in to access this section"
			redirect_to root_path
		end
	end
end
