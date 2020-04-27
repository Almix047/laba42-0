class Api::V1::ProjectsController < ApiController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_project, only: %i[index]
  before_action :set_user, only: %i[create]

  def index
    @projects
  end

  def show
    @project = Project.find(params[:id])
    @applies = Project.find(params[:id]).applies
    @comments = Project.find(params[:id]).comments
  end

  def create
    @project = @user.projects.new(project_params)
    if @project.save
      render json: { status: 201,
                     response: 'Created',
                     message: @project }
    else
      render json: { status: 422,
                     response: 'Unprocessable Entity',
                     message: @project.errors.messages }
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      render json: { status: 200,
                     response: 'Updated',
                     message: @project }
    else
      render json: { status: 422,
                     response: 'Unprocessable Entity',
                     message: @project.errors.messages }
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      render json: { status: 200,
                     response: 'Deleted' }
    else
      render json: { status: 422,
                     response: 'Unprocessable Entity',
                     message: @project.errors.messages }
    end
  end

  private

  def set_project
    @projects = Project.includes(:user)
  end

  def project_params
    params.require(:project).permit(:title, :info, :cost, :cost_type,
                                    :project_type, :deadline, :skills)
  end

  def set_user
    @user = current_user
  end
end
