class UsersController < ApplicationController
  USER_COUNTS = 12

  def index
    @users = User.with_attached_image.order(:id).page(params[:page]).per(USER_COUNTS)
  end

  def show
    @user = User.find(params[:id])
    @attendance_events = @user.events.approved.limit(3).order(held_at: :asc)
    @my_events = @user.events.limit(3).order(held_at: :desc)
    @favorite_events = @user.favorite_events.limit(3).order(held_at: :asc)
  end
end
