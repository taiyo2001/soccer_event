Team.destroy_all

League.all.each do |_v|
  team_count = [*4..10].sample
  leagues = League.all.to_a

  team_count.times do |_n|
    league = leagues.sample
    name = Faker::Sports::Football.team
    Team.create!(name:, league:)
  end
end
