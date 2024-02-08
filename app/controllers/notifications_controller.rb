class NotificationsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @notifications = @user.notifications.order(created_at: :desc).page(params[:page])
  end

  def show
    notification = Notification.find(params[:id])

    if notification.is_unread
      notification.is_unread = false
      notification.save!
    end

    redirect_to notification.url
  end
end
