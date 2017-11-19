class Api::V1::IndexController < ApplicationController

  def render_top_users
    @t_u = UserQueries.top_users
    render json: {users: @t_u}
  end

end
