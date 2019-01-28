class CreateFriendshipRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friendship_requests do |t|
      t.integer :sender
      t.integer :recipient

      t.timestamps
    end
  end
end
