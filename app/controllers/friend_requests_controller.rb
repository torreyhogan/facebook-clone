class FriendRequestsController < ApplicationController

	def new
		@friendrequest = FriendRequest.new()
	end

	def create
		@friendrequest = FriendRequest.new(receiver_id: params[:receiver_id].to_i)
		@friendrequest.sender_id = current_user.id 
		if @friendrequest.save
			redirect_to current_user
		else
			render 'new'
		end
	end

	def destroy
		@friendrequest = FriendRequest.where(receiver_id: params[:friend_id], sender_id: current_user.id) || 
			FriendRequest.where(receiver_id: current_user.id, sender_id: params[:friend_id])
    @friendrequest.destroy
    flash[:notice] = "Friend request denied"
    redirect_to current_user
		
	end

	private

	def friendrequest_params
		params.require(:friend_request).permit(:receiver_id)
	end
end
