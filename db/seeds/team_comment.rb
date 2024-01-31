TeamComment.destroy_all

Team.all.each do |_v|
  team_comment_counts = [*4..10].sample
  users = User.all.to_a
  teams = Team.all.to_a

  team_comment_counts.times do |_n|
    user = users.sample
    team = teams.sample
    content = Faker::Games::Pokemon.move
    TeamComment.create!(user:, team:, content:)
  end
end
