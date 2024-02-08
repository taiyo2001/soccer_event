class Team < ApplicationRecord
  has_many :users, foreign_key: :favorite_team_id
  has_many :team_comments, dependent: :destroy
  belongs_to :league

  TEAM_COUNTS = 10
  TEAM_COMMENT_COUNTS = 5

  def new_comments
    team_comments.includes(:user).order(created_at: :desc).limit(TEAM_COMMENT_COUNTS)
  end

  def self.fetch_teams
    teams = order(id: :asc).limit(TEAM_COUNTS)

    team_hash = {}
    teams.each do |team|
      team_hash[team.name] = team.id
    end
    team_hash
  end
end
