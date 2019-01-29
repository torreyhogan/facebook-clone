class FriendshipsController < ApplicationController
  def create
  	@friendship = current_user.friendship.build(friend_id: params[:friend_id])
  	if @friendship.save
  		flash[:success] = "Friendship accepted"
  end

  def destroy
  end

  private

end
