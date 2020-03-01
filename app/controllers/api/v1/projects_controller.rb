
class Api::V1::ProjectsController < ApiController
  before_action :authenticate_api_user!
  before_action :set_project

  def index
    @projects
  end

  def show
    @project = Project.find(params[:id])
    @applies = Project.find(params[:id]).applies
    @comments = Project.find(params[:id]).comments
  end

  private

  def set_project
    @projects = Project.includes(:user)
  end
end
