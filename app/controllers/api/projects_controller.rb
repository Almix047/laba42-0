
class Api::ProjectsController < ApiController
  before_action :set_project

  def index
    @projects
  end

  def show
    @project = Project.find(params[:id])
  end

  private

  def set_project
    @projects = Project.includes(:user)
  end
end
