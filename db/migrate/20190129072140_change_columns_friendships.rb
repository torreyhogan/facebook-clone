class ChangeColumnsFriendships < ActiveRecord::Migration[5.2]
  def change
  	rename_column :friendships, :user_one, :user_id
  	rename_column :friendships, :user_two, :friend_id
  end
end
