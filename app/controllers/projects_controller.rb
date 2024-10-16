class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :change_status]

  def index
    @projects = Project.all
  end

  def show
    @comments = @project.comments.includes(:user).order(created_at: :asc)
    @status_changes = @project.status_changes.includes(:user).order(created_at: :asc)
    # Combine and sort activities if using a unified activity feed
    @activities = (@comments + @status_changes).sort_by(&:created_at)
    @activity = Activity.new # Initialize a new Activity for form use
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

  # New action to handle status change
  def change_status
    previous_status = @project.status
    if @project.update(status: params[:status])
      # Create an activity log for the status change
      Activity.create(
        user: current_user,
        project: @project,
        previous_status: previous_status,
        new_status: @project.status
      )
      redirect_to @project, notice: 'Project status was successfully updated.'
    else
      redirect_to @project, alert: 'Failed to update project status.'
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
