class UpdateFriendRequest < ActiveRecord::Migration[5.1]
  def change
    change_column :friend_requests, :pending, :boolean, :default => true
  end
end
