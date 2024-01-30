class TeamComment < ApplicationRecord
  belongs_to :user
  belongs_to :team

  validates :content, presence: true, length: { maximum: 500 }
end
