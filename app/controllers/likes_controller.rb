class LikesController < ApplicationController

	def new
		@likes = current_user.likes.build
	end

  def create
  	# session[:return_to] ||= request.referer
  	@likes = current_user.likes.build(post_id: params[:post_id])
  	if @likes.save
  		flash[:success] = "Post liked"
  		redirect_back(fallback_location: root_path)
  	else
  		flash[:failure] = "couldn't like"
  	end

  end

  def destroy
  	@likes = current_user.likes.find_by(post_id: params[:post_id])
  	@likes.destroy
  	flash[:success] = "unliked post"
  	redirect_back(fallback_location: root_path)
  end
end
