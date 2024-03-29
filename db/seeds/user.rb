require_relative './en_faker'

# 認証にはdeviseを使用
# test user
User.create!(
  name: 'DevUser',
  email: 'soccersample@example.com',
  password: 'password',
  age: 20,
  gender: 'man'
)

50.times do |i|
  User.create!(
    name: "#{EnFaker::Games::Pokemon.name}#{i + 1}",
    email: "sample#{i + 1}@example.com",
    password: 'password',
    age: rand(20..60),
    gender: %w[man woman no_answer].sample
  )
end
