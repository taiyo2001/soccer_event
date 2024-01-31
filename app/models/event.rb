class Event < ApplicationRecord
  attr_accessor :zipcode_address, :other_address

  scope :open, -> { where('deadline_at > ?', Time.current) }
  scope :closed, -> { where('deadline_at < ?', Time.current) }

  has_many :event_attendances
  has_many :applied_users, through: :event_attendances, source: :user
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

  private

  def held_at_and_deadline_at_must_be_valid_dates
    return unless held_at.present? && deadline_at.present?

    errors.add(:held_at, 'must be a future date') if held_at < Date.current

    errors.add(:deadline_at, 'must be a future date') if deadline_at < Date.current

    return unless held_at <= deadline_at

    errors.add(:held_at, 'must be after the deadline')
  end
end
