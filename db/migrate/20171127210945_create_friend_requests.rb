class CreateFriendRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :friend_requests do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.boolean :accepted
      t.boolean :pending, default: false
      t.timestamps
    end
  end
end
