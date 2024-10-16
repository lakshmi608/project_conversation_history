class CommentsController < ApplicationController
  before_action :set_project

  def create
    @comment = @project.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @project, notice: 'Comment was successfully added.'
    else
      redirect_to @project, alert: 'Failed to add comment.'
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
