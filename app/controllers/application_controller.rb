class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authorized

  def issue_auth_token payload
   JWT.encode(payload, ENV["auth_token"])
  end

  def decode_token token
    begin
      JWT.decode(token, ENV["auth_token"])
    rescue
      JWT::DecodeError
      return nil
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user
    authenticate_or_request_with_http_token do |token, options|
      decoded_token = decode_token token
      user_id = decoded_token[0]["user_id"]
      @user ||= User.find(user_id)
    end
  end

  def authorized
    render json: {message: "You Can't Go Here. Muhahaha", status: 404} unless logged_in?
  end

end
