League.all.each do |_v|
  team_count = [*4..10].sample
  leagues = League.all.to_a

  team_count.times do |_n|
    league = leagues.sample
    name = Faker::Sports::Football.team
    description = Faker::JapaneseMedia::OnePiece.quote
    Team.create!(name:, league:, description:)
  end
end
