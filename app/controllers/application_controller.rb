class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :set_search_event_form
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :fetch_notifications, if: :user_signed_in?

  protected

  def configure_permitted_parameters
    keys = %i[name age gender favorite_team_id image]

    devise_parameter_sanitizer.permit(:sign_up, keys:)
    devise_parameter_sanitizer.permit(:account_update, keys:)
  end

  def after_sign_in_path_for(_resource)
    root_path
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end

  def set_search_event_form
    @q = Event.open.ransack(params[:q])
    @q.sorts = 'created_at asc' if params[:q].blank? || params[:q][:s].blank?
  end

  private

  def fetch_notifications
    @unread_notifications = current_user.notifications.unread
  end
end
