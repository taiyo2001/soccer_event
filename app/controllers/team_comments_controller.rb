class TeamCommentsController < ApplicationController
  def create
    @team_comment = TeamComment.new(team_comment_params)
    @team_comment.user = current_user

    if @team_comment.save
      redirect_to team_path(@team_comment.team_id), notice: 'コメントしました！'
    else
      @team = Team.find(@team_comment.team_id)
      render 'teams/show'
    end
  end

  private

  def team_comment_params
    params.require(:team_comment).permit(:content, :team_id)
  end
end
