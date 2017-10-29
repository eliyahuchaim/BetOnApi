class Bet < ApplicationRecord
  belongs_to :party
  has_many :wagers


  def self.create_bet payload
    start_d = Date.parse(payload["start_date"])
    end_d = Date.parse(payload["end_date"])
    @bet = Bet.create(bet_type: payload["bet_type"], value: payload["value"], ended: false, party_id: payload["party_id"], start_date: start_d, end_date: end_d)
    if @bet
      @bet
    else
      @bet.errors.full_messeges
    end
  end

  def self.find_ended_bets
    today = Time.now.to_date
    due_bets = []
    for bet in Bet.all
      bet.end_date <= today ? due_bets << bet : nil
    end
    self.find_wagers due_bets
  end

  def self.find_wagers bets
    bets.each do |b|
      bet = Bet.find(b.id)
      wagers = bet.wagers
      User.update_user_points(wagers, bet.result, bet.value)
    end
  end





end
