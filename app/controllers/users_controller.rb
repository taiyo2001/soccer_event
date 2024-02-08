class UsersController < ApplicationController
  USER_COUNTS = 12

  def index
    @users = User.with_attached_image.order(:id).page(params[:page]).per(USER_COUNTS)
  end

  def show
    @user = User.find(params[:id])

    if @user == current_user
      all_attendance_events = current_user.events.approved.open
      @attendance_events = all_attendance_events.limit(3).order(held_at: :asc)
      @attendance_events_count = all_attendance_events.count
    end

    all_my_events = @user.events
    @my_events = all_my_events.limit(3).order(held_at: :desc)
    @my_events_count = all_my_events.count

    all_favorite_events = @user.favorite_events
    @favorite_events = all_favorite_events.limit(3).order(held_at: :asc)
    @favorite_events_count = all_favorite_events.count
  end
end
