class FriendRequestsController < ApplicationController

	def new
		@friendrequest = FriendRequest.new()
	end

	def create
		@friendrequest = FriendRequest.new(friendrequest_params)
		@friendrequest.sender_id = current_user.id 
		if @friendrequest.save
			redirect_to current_user
		else
			render 'new'
		end
	end

	def destroy
	end

	private

	def friendrequest_params
		params.require(:friend_request).permit(:receiver_id)
	end
end
