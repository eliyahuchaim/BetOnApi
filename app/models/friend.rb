class Friend < ApplicationRecord
  validate :non_duplicates, :on => :create


  def non_duplicates
    for friend in Friend.all
      errors.add(:friend, "users are already friends") if check_if_friends_exist friend, user1, user2
      end
    end
  end

  def check_if_friends_exist friend, user1, user2
    if friend.user1 == user1 && friend.user2 == user2 || friend.user1 == user2 && friend.user2 == user1
    true
  end
end
