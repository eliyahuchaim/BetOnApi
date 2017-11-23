class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :show, :index]

  def create
    @user = User.create(user_params)
    if @user.id
      render json: {user: @user}
    else
      render json: {message: "User was not created"}
    end
  end

  def index
    exclude_columns = ['password_digest', 'created_at', 'updated_at']
    columns = User.attribute_names - exclude_columns
    @users_arr = User.select(columns)
    render json: {all_users: @users_arr}
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
    params.require(:user).permit(:firstname, :lastname, :username, :password, :avatar)
  end

  def give_points_params
    params.require(:user).permit(:receiving_user_id, :points)
  end








end
