class Api::V1::WagersController < ApplicationController
  skip_before_action :authorized, only: [:index]

  def create
    @bet = Bet.find(wager_params[:bet_id])
    if @bet.id
      @wager = Wager.create(bet_answer: wager_params[:bet_answer], user_id: current_user.id, bet_id: wager_params[:bet_id])
    end
    render json: {message: "Wager Successful", wager: @wager} if @wager.id
  end

  def show
    @wager = Wager.find(params[:id])
    render json: {wager: @wager}
  end

  def index
  end

  def users_wagers
    @users_wagers = User.find(params[:id]).wagers
    @wagers_with_bets = @users_wagers.map do |wager|
      @bet = Bet.find(wager.bet_id)
      {bet: @bet.bet_type, value: @bet.value, result: @bet.result, ended: @bet.ended, start_date: @bet.start_date, end_date: @bet.end_date, wager: wager}
    end
    render json: {wagers: @wagers_with_bets}
  end


  private

  def wager_params
    params.require(:wager).permit(:bet_answer, :user_id, :bet_id)
  end

end
