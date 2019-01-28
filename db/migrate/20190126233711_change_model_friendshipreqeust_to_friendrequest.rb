class ChangeModelFriendshipreqeustToFriendrequest < ActiveRecord::Migration[5.2]
  def change
  	rename_table :friendship_requests, :friend_requests
  end
end
