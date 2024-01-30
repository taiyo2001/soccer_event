class LeaguesController < ApplicationController
  def index
    @leagues = League.all.page(params[:page])
  end

  def show
    @league = League.find(params[:id])
    @teams = Team.where(league_id: params[:id]).page(params[:page])
  end
end
