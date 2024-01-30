class Event < ApplicationRecord
  has_many :event_attendances
  has_many :applied_users, through: :event_attendances, source: :user
  belongs_to :zipcode
  belongs_to :master, class_name: 'user'

  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :people_limit, numericality: { greater_than_or_equal_to: 0 }
  validates :held_at, presence: true
  validates :deadline_at, presence: true
  validate :held_at_and_deadline_at_must_be_valid_dates

  private

  def held_at_and_deadline_at_must_be_valid_dates
    return unless held_at.present? && deadline_at.present?

    errors.add(:held_at, 'must be a future date') if held_at < Date.current

    errors.add(:deadline_at, 'must be a future date') if deadline_at < Date.current

    return unless held_at >= deadline_at

    errors.add(:held_at, 'must be before the deadline')
  end
end
