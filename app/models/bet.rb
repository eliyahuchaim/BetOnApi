class Bet < ApplicationRecord
  belongs_to :party
  has_many :wagers

  def self.create_bet payload, current_user_id
    start_d = Date.parse(Time.now.to_s) if payload["start_date"].length == 0
    start_d = Date.parse(payload["start_date"])
    end_d = Date.parse(payload["end_date"])

    check = Bet.user_is_in_party current_user_id, payload["party_id"]
    if check != false
      @bet = Bet.create(bet_type: payload["bet_type"], value: payload["value"], ended: false, party_id: payload["party_id"], start_date: start_d, end_date: end_d, owner_id: current_user_id)
      if @bet
        @bet
      else
        false
      end
    end
  end

  def self.update_bet bet_id, payload, current_user_id
    @bet = Bet.find(bet_id)
    @bet.update(result: payload["result"]) if @bet.owner_id == current_user_id
    @bet
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

  def self.user_is_in_party current_user_id, party_id
    false unless Party.find(party_id).users.select {|user| user.id == current_user_id}.length > 0
  end

end
