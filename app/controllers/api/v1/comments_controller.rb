class Api::V1::CommentsController < ApiController
  before_action :authenticate_user!

  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.new(comment_params.merge(user_id: current_user.id))
    if @comment.save
      render json: { status: 201,
                     response: 'Created',
                     message: @comment }
    else
      render json: { status: 422,
                     response: 'Unprocessable Entity',
                     message: @comment.errors.messages }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
