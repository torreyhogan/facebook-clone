class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :author_id
      t.string :content
      t.integer :likes

      t.timestamps
    end
  end
end
