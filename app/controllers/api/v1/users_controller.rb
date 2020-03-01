
class Api::V1::UsersController < ApiController
  before_action :authenticate_api_user!

  def me
    render json: { jti: @current_user.jti }
  end
end
