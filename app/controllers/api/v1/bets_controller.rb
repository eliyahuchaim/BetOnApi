class Api::V1::BetsController < ApplicationController
  skip_before_action :authorized, only: [:show]

  def create
    @bet = Bet.create_bet(create_bet_params, current_user.id)
     if @bet
       render json: {bet: @bet}
     else
       render json: {message: "Bet was not created", code: 400}
     end
  end

  def update
    @bet = Bet.update_bet params[:id], update_bet_params, current_user.id
    render json: {bet: @bet}
  end


  def destroy
    render json: {message: "Bet was destroyed"} if Bet.destroy(params[:id])
  end


  def show
    @bet = Bet.find(params[:id])
    render json: {bet: @bet}
  end



  private

  def create_bet_params
    params.require(:bet).permit(:bet_type, :value, :party_id, :start_date, :end_date, :owner_id)
  end

  def update_bet_params
    params.require(:bet).permit(:result)
  end



end
