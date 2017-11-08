class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :show]

  def create
    @user = User.create(user_params)
    if @user.id
      render json: {user: @user}
    else
      render json: {message: "User was not created"}
    end
  end


  def update
  end


  def show
    @user = User.find(params[:id])
    render json: {user: @user} if @user
  end


  def friends
    @user = User.find(current_user.id)
    @friends = @user.friends
    render json: {friends: @friends} if !!@friends
  end


  def give_points
    @user = User.find(current_user.id)
    points = give_points_params[:points].to_i
    render json: {status: "You don't have enough points"} unless @user.give_points(give_points_params[:receiving_user_id], points)
  end


  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :username, :password)
  end

  def give_points_params
    params.require(:user).permit(:receiving_user_id, :points)
  end








end
