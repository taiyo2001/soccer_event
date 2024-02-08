class Notification < ApplicationRecord
  NOTIFICATIONS_LIMIT = 10

  belongs_to :user

  # 3ヶ月以内の通知を取得
  scope :recent, -> { where('created_at > ?', Time.current.ago(3.month)).limit(NOTIFICATIONS_LIMIT).order(created_at: :desc) }
  scope :unread, -> { recent.where(is_unread: true) }
end
