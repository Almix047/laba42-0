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

  def destroy
    @apply = Apply.find(params[:id])
    if @apply.destroy
      render json: { status: 200,
                     response: 'Deleted' }
    else
      render json: { status: 422,
                     response: 'Unprocessable Entity',
                     message: @apply.errors.messages }
    end
  end

  def appointment
    Apply.transaction do
      @apply = Apply.find(params[:id])
      @apply.project.update!(employee: @apply.user_id)
      @apply.update!(apply_status: 'accept')
      render json: { message: "User_id #{@apply.user_id} accepted to Project_id #{@apply.project.id}" }
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
