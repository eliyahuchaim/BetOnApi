class CreateFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :friends do |t|
      t.integer :user1
      t.integer :user2

      t.timestamps
    end
  end
end
