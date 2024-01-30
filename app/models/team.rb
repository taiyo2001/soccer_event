class Team < ApplicationRecord
  has_many :users, foreign_key: :favorite_team_id
  belongs_to :league
end
