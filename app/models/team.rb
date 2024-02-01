class Team < ApplicationRecord
  has_many :users, foreign_key: :favorite_team_id
  has_many :team_comments, dependent: :destroy
  belongs_to :league

  TEAM_COMMENT_COUNTS = 5

  def new_comments
    team_comments.includes(:user).order(created_at: :desc).limit(TEAM_COMMENT_COUNTS)
  end
end
