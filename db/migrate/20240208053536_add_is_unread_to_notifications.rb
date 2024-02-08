class AddIsUnreadToNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :is_unread, :boolean, default: true, null: false
  end
end
