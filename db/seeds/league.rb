League.create!(name: 'プレミアリーグ')
League.create!(name: 'ラ・リーガ')
League.create!(name: 'セリエA')
League.create!(name: 'ブンデスリーガ')
League.create!(name: 'リーグアン')

50.times do
  League.create!(
    name: Faker::Sports::Football.competition
  )
end
