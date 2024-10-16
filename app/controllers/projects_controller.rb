class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update]

  def index
    @projects = Project.all
  end

  def show
    @comments = @project.comments.includes(:user).order(created_at: :asc)
    @status_changes = @project.status_changes.includes(:user).order(created_at: :asc)
    # Combine and sort activities if using a unified activity feed
    @activities = (@comments + @status_changes).sort_by(&:created_at)
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(project_params)
    @project.status = 'New' if @project.status.blank?

    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def edit
    # Edit logic
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :status)
  end
end
