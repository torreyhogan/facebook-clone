class FriendshipsController < ApplicationController
  def create
  	@friendship = current_user.friendships.build(friend_id: params[:friend_id].to_i)
    # @other_friendship = Friendship.new(user_id: params[:friend_id], friend_id: current_user.id)
  	if @friendship.save #&& @other_friendship.save
  		flash[:success] = "Friendship accepted"
  		@friendrequest = current_user.received_friend_requests.find_by(sender_id: params[:friend_id])
  		@friendrequest.destroy
  		redirect_to users_path
  	else
  		flash[:failure] = "Could not accept friend request."
  		# redirect_to  users_path
  	end

  end

  def destroy
    @friendship = current_user.friendships.find_by(friend_id: params[:friend_id])
    @friendship.destroy
    flash[:notice] = "Removed friendship to #{@user.find(params[:friend_id])}"
    redirect_to current_user
  end

end
