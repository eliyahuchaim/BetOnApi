class User < ApplicationRecord
  has_secure_password
  has_many :groups
  has_many :parties, through: :groups
  has_many :wagers

  def friends
    UserQueries.find_friends(self.id)
  end

  def self.update_user_points(wagers, bet_result, bet_value)
    wagers.each do |w|
      user = User.find(w.user_id)
      w.bet_answer === bet_result ? user.increment!("points", by = bet_value) : user.decrement!("points", by = bet_value)
      user.save!
    end
  end



end
