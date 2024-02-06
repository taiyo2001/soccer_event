require 'faker'
require 'gimei'

EventComment.destroy_all

events = Event.includes(event_attendances: :user).all

comments = []
events.each do |event|
  event.event_attendances.approve.each do |attendance|
    user = attendance.user
    comments << EventComment.new(
      event:,
      user:,
      content: "#{user.name}です、よろしくお願いします。"
    )
  end
end

EventComment.import!(comments)
