class User < ApplicationRecord
  NAME_REGEX = /\A\w+\z/

  has_one_attached :image
  has_many :team_comments, dependent: :destroy
  has_many :events, dependent: :destroy, foreign_key: 'master_id'
  has_many :event_attendances, dependent: :destroy
  has_many :applied_events, through: :event_attendances, source: :event
  has_many :event_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  belongs_to :favorite_team, class_name: 'Team', optional: true

  validates :name, presence: true, length: { maximum: 250 }, uniqueness: true, format: { with: NAME_REGEX }
  validates :age, presence: true, numericality: { only_integer: true }
  validates :gender, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def not_applied_events
    Event.where.not(id: applied_events.pluck(:id))
  end
end
