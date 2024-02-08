class TeamComment < ApplicationRecord
  SOCCER_EVENT_URL = 'http://localhost:3000'.freeze

  mentionable_as :content

  belongs_to :user
  belongs_to :team

  validates :content, presence: true, length: { maximum: 500 }

  def after_save_mention(new_mentions)
    new_mentions.each do |new_mention|
      mentioned_name = new_mention[1..]
      mentioned_user = User.find_by(name: mentioned_name)

      next unless mentioned_user

      EventMailer.with(mentioned_user:, team:, mentioning_user: user).team_comment_email.deliver_now
      Notification.create!(user: mentioned_user, message: "コメントで#{user.name}さんからメンションされました",
                           url: SOCCER_EVENT_URL + Rails.application.routes.url_helpers.team_path(team))
    end
  end
end
