class User < ApplicationRecord
  has_many :team_comments, dependent: :destroy
  belongs_to :favorite_team, class_name: 'Team', optional: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
