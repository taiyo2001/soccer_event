class EventAttendance < ApplicationRecord
  extend Enumerize

  belongs_to :event
  belongs_to :user

  enumerize :status, in: %i[request approve reject], default: 'request', scope: :shallow, predicates: true
end
