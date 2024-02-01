require 'faker'
require 'gimei'

PLACE = %w[スタジアム フィールド 公園 空き地].freeze

user_ids = User.all.pluck(:id)
test_user_id = User.find_by(email: 'soccersample@example.com').id
zipcodes = Zipcode.includes(%i[town city prefecture]).all
now = Time.now

events = []
10.times do |i|
  deadline_at = Time.new(
    now.year,
    now.month,
    now.day + rand(1..30),
    rand(0..23),
    rand(0..59),
    rand(0..59)
  )
  zipcode = zipcodes.sample

  events << Event.new(
    master_id: test_user_id,
    name: "一緒に遊べる人募集中！！ #{i + 1}",
    zipcode:,
    address: "#{zipcode.prefecture.name}#{zipcode.city.name}#{zipcode.town.name}#{Faker::Address.street_address}",
    place: "#{Faker::Games::Pokemon.move}#{PLACE.sample}",
    price: 50 * rand(1..200),
    people_limit: rand(1..50),
    description: Faker::Lorem.paragraph,
    deadline_at:,
    held_at: deadline_at.days_since(rand(1..3))
  )
end

50.times do |i|
  deadline_at = Time.new(
    now.year,
    now.month,
    now.day + rand(1..30),
    rand(0..23),
    rand(0..59),
    rand(0..59)
  )
  zipcode = zipcodes.sample

  events << Event.new(
    master_id: user_ids.sample,
    name: "運動を楽しみませんか！？ #{i + 1}",
    zipcode:,
    address: "#{zipcode.prefecture.name}#{zipcode.city.name}#{zipcode.town.name}#{Faker::Address.street_address}",
    place: "#{Faker::Games::Pokemon.move}#{PLACE.sample}",
    price: 50 * rand(1..200),
    people_limit: rand(1..50),
    description: Faker::Lorem.paragraph,
    deadline_at:,
    held_at: deadline_at.days_since(rand(1..3))
  )
end

Event.import!(events)
