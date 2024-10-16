class StatusChangesController < ApplicationController
  before_action :set_project

  def create
    @status_change = @project.status_changes.build(status_change_params)
    @status_change.user = current_user
    @status_change.previous_status = @project.status
    @project.status = @status_change.new_status

    ActiveRecord::Base.transaction do
      @project.save!
      @status_change.save!
    end

    redirect_to @project, notice: 'Status was successfully updated.'
  rescue ActiveRecord::RecordInvalid
    redirect_to @project, alert: 'Failed to update status.'
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def status_change_params
    params.require(:status_change).permit(:new_status)
  end
end
