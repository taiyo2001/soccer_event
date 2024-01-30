Team.destroy_all

League.all.each do |_v|
  team_count = [*4..10].sample
  leagues = League.all.to_a

  team_count.times do |n|
    league = leagues.sample
    name = Faker::Name.initials
    Team.create!(name:, league:)
  end
end
