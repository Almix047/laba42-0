class Api::V1::AppliesController < ApiController
  before_action :authenticate_user!
  before_action :set_user, only: %i[create]

  def create
    @apply = @user.applies.new(apply_params)
    if @apply.save
      render json: { status: 201,
                     response: 'Created',
                     message: @apply }
    else
      render json: { status: 422,
                     response: 'Unprocessable Entity',
                     message: @apply.errors.messages }
    end
  end

  private

  def apply_params
    params.require(:apply).permit(:project_id)
  end

  def set_user
    @user = current_user
  end
end
