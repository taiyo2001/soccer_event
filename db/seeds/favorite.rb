Favorite.destroy_all

users = User.all
events = Event.all

users.each do |user|
  favorite_counts = rand(1..10)
  favorite_events = events.sample(favorite_counts)

  favorite_events.each do |favorite_event|
    Favorite.create!(user:, event: favorite_event)
  end
end
