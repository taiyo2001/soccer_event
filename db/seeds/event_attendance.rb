STATUS = %w[requested canceled approved rejected].freeze

test_user_id = User.find_by(email: 'soccersample@example.com').id
no_test_user_ids = User.where.not(id: test_user_id).pluck(:id)
event_ids = Event.all.pluck(:id)
no_test_user_combinations = event_ids.product(no_test_user_ids).shuffle
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
