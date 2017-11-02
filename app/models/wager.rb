class Wager < ApplicationRecord
  belongs_to :user
  has_one :bet
  validate :validate_user_points, :cant_bet_twice

  def validate_user_points
    @user = User.find(user_id)
    @bet = Bet.find(bet_id)
    errors.add(:points, "You dont have enough points to bet on this wager") unless @user.points - @bet.id > 0
  end

  def cant_bet_twice
    @bet = Bet.find(bet_id)
    errors.add(:user_id, "you cannot bet twice on this bet") if !!@bet.wagers.find_by(user_id: user_id)
  end



end
