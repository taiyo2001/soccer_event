class Event < ApplicationRecord
  attr_accessor :zipcode_address, :other_address

  scope :open, -> { where('deadline_at > ?', Time.current) }
  scope :closed, -> { where('deadline_at < ?', Time.current) }
  scope :approved, -> { joins(:event_attendances).where(event_attendances: { status: 'approved' }) }

  has_many :event_attendances, dependent: :destroy
  has_many :applied_users, through: :event_attendances, source: :user
  has_many :event_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :zipcode
  belongs_to :master, class_name: 'User'

  validates :name, presence: true
  validates :address, presence: true
  validates :place, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :people_limit, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :held_at, presence: true
  validates :deadline_at, presence: true
  validate :held_at_and_deadline_at_must_be_valid_dates

  def calc_time_remaining
    time_difference = (deadline_at - Time.current).to_i
    days = time_difference / (24 * 60 * 60)
    hours = (time_difference % (24 * 60 * 60)) / (60 * 60)
    minutes = (time_difference % (60 * 60)) / 60

    "#{days}日 #{hours}時間 #{minutes}分"
  end

  def can_request?
    return true if people_limit.nil?

    people_limit > event_attendances.approved.count
  end

  def applied?(user)
    event_attendances.where(user:).present?
  end

  def approved_user?(user)
    event_attendances.find_by(user:)&.approved?
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[zipcode name address place price people_limit held_at deadline_at created_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[zipcode prefectures]
  end

  private

  def held_at_and_deadline_at_must_be_valid_dates
    return unless held_at.present? && deadline_at.present?

    errors.add(:held_at, 'must be a future date') if held_at < Date.current

    errors.add(:deadline_at, 'must be a future date') if deadline_at < Date.current

    return unless held_at <= deadline_at

    errors.add(:held_at, 'must be after the deadline')
  end
end
