class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.integer :user_one
      t.integer :user_two

      t.timestamps
    end
  end
end
