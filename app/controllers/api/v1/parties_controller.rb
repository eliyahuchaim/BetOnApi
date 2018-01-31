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

  def invite_user
    @party_id = party_invite_params[:party_id]
    @user_id = party_invite_params[:invited_user_id]

    invite = Party.invite_people_to_party @party_id, @user_id, current_user.id

    if invite
      render json: {result: User.find(@user_id).username + " was invited to your party"}
    else
      render json: {error: invite.errors.full_messages}
    end
  end

  def mass_invite
    @users_arr = params["party"]["users_arr"]
    @party_id = party_mass_invite_params[:party_id]

    invite = Party.mass_invite @party_id, @users_arr, current_user.id

    render json: {result: "success", party_users: Party.find(@party_id).users.map {|u| {username: u.username}}} if invite != false
  end


  private

  def party_params
    params.require(:party).permit(:title)
  end

  def party_invite_params
    params.require(:party).permit(:party_id, :invited_user_id, :owner_id)
  end

  def party_mass_invite_params
    params.require(:party).permit(:party_id, :users_arr, :owner_id)
  end





end
