class EventAttendance < ApplicationRecord
  extend Enumerize

  belongs_to :event
  belongs_to :user

  enumerize :status, in: %i[requested canceled approved rejected], default: 'requested', scope: :shallow, predicates: true

  validate :status_must_be_requested, unless: :new_record?

  private

  def status_must_be_requested
    errors.add(:status, "cannot be changed unless it is 'requested'") unless status_changed? && status_was == 'requested'
  end
end
