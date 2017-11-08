class Api::V1::PartiesController < ApplicationController
  skip_before_action :authorized, only: [:index, :public_party_info]


  def create
    @party = Party.create_party(current_user.id, party_params[:title])
    render json: {party: @party} if @party
  end


  def index
    render json: {parties: Party.all}
  end


  def public_party_info
    @party = Party.find(params[:id].to_i)
    @owner = User.find(@party.owner_id)
    @users = @party.users.map {|u| {user_id: u.id, username: u.username}}
    render json: {party: @party.title, owner: {username: @owner.username, owner_id: @owner.id}, users: @users}
  end


  private

  def party_params
    params.require(:party).permit(:title, :owner_id)
  end

  def party_invite_params
    params.require(:party).permit(:party_id, :invited_user_id, :owner_id)
  end

  def party_mass_invite_params
    params.require(:party).permit(:party_id, :users_arr, :owner_id)
  end





end
