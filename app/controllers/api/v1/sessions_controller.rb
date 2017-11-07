class Api::V1::SessionsController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      payload = {user_id: @user.id}
      token = issue_auth_token(payload)
      render json: {what_you_looking_at: token, user_id: @user.id}
    else
      render json: {message: "Authorization Error"}
    end
  end



end
