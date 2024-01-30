class Team < ApplicationRecord
  has_many :users, foreign_key: :favorite_team_id
  has_many :team_comments, dependent: :destroy
  belongs_to :league
end
