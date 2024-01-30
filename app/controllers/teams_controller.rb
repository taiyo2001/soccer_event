class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
    @team_comment = TeamComment.new
  end
end
