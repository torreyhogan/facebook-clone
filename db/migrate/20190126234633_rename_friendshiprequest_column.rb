class RenameFriendshiprequestColumn < ActiveRecord::Migration[5.2]
  def change
  	rename_column :friend_requests, :sender, :sender_id
  	rename_column :friend_requests, :recipient, :receiver_id
  end
end
