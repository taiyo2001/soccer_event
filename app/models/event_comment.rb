class EventComment < ApplicationRecord
  SOCCER_EVENT_URL = 'http://localhost:3000'.freeze

  mentionable_as :content

  belongs_to :event
  belongs_to :user

  validates :content, presence: true

  def after_save_mention(new_mentions)
    new_mentions.each do |new_mention|
      mentioned_name = new_mention[1..-1]
      mentioned_user = User.find_by(name: mentioned_name)

      EventMailer.with(mentioned_user:, event:, mentioning_user: user).event_comment_email.deliver_now
      Notification.create!(user: mentioned_user, message: "コメントで#{user.name}さんからメンションされました",
                           url: SOCCER_EVENT_URL + Rails.application.routes.url_helpers.event_path(event))
    end
  end
end
