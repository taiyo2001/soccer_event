require 'faker'
require 'gimei'

PLACE = %w[スタジアム フィールド 公園 空き地].freeze

user_ids = User.all.pluck(:id)
test_user_id = User.find_by(email: 'soccersample@example.com').id

# productionではデータ件数が多くすべてを処理できないので100件と取得
zipcodes = Zipcode.includes(%i[town city prefecture]).order('RANDOM()').limit(100)

now = Time.now

events = []
10.times do |i|
  deadline_at = now.advance(days: rand(1..30), hours: rand(0..23), minutes: rand(0..59), seconds: rand(0..59))
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
  deadline_at = now.advance(days: rand(1..30), hours: rand(0..23), minutes: rand(0..59), seconds: rand(0..59))
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
