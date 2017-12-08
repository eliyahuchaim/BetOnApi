class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :index, :publicShow]

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

  def publicShow
    exclude_columns = {
      "password_digest" => 1,
      "created_at" => 1,
      "updated_at" => 1
    }
    @user = {}
    @tempUser = User.find(params[:id])
    @attributes = @tempUser.attributes
    @tempUser.attribute_names.each do |att|
      @user[att.to_sym] = @attributes[att] if !exclude_columns[att]
    end
    render json: {user: @user} if @user
  end


  def private_show
    @tempUser = User.find(current_user.id)
    exclude_columns = {
      "password_digest" => 1,
      "created_at" => 1,
      "updated_at" => 1
    }
    @user = {}
    @attributes = @tempUser.attributes
    @tempUser.attribute_names.each do |att|
      @user[att.to_sym] = @attributes[att] if !exclude_columns[att]
    end
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
