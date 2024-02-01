class UsersController < ApplicationController
  USER_COUNTS = 12

  def index
    @users = User.with_attached_image.order(:id).page(params[:page]).per(USER_COUNTS)
  end

  def show
    @user = User.find(params[:id])
  end
end
