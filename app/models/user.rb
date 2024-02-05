class User < ApplicationRecord
  has_one_attached :image
  has_many :team_comments, dependent: :destroy
  has_many :events, dependent: :destroy, foreign_key: 'master_id'
  has_many :event_attendances, dependent: :destroy
  has_many :event_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  belongs_to :favorite_team, class_name: 'Team', optional: true

  validates :name, presence: true, length: { maximum: 250 }
  validates :age, presence: true, numericality: { only_integer: true }
  validates :gender, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
