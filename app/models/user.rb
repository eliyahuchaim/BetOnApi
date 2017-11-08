class User < ApplicationRecord
  has_secure_password
  has_many :groups
  has_many :parties, through: :groups
  has_many :wagers
  validates_uniqueness_of :username, :message => "is already taken"

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

  def give_points receiving_user_id, points
    @receiving_user = User.find(receiving_user_id)
    if self.points - points > 0
      updated_points = self.points - points
      self.update(points: updated_points)
      @receiving_user.increment!("points", by = points)
    else
      false
    end
  end

  def parties_user_owns
    Party.find_by(owner_id: self.id)
  end


  def request_points from_user_id, points
  end

end
