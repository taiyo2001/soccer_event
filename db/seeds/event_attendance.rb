EventAttendance.destroy_all

STATUS = %w[request approve reject].freeze

user_ids = User.all.pluck(:id)
test_user_id = User.find_by(email: 'soccersample@example.com').id
event_ids = Event.all.pluck(:id)
no_test_user_combinations = event_ids.product(user_ids).shuffle
test_user_combinations = event_ids.product([test_user_id]).shuffle

attendances = []
10.times do |_i|
  event_id, user_id = test_user_combinations.pop
  attendances << EventAttendance.new(
    event_id:,
    user_id:,
    status: STATUS.sample
  )
end

200.times do |_i|
  event_id, user_id = no_test_user_combinations.pop
  attendances << EventAttendance.new(
    event_id:,
    user_id:,
    status: STATUS.sample
  )
end

EventAttendance.import!(attendances)
