class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name age gender favorite_team_id])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name age gender favorite_team_id])
  end

  def after_sign_in_path_for(_resource)
    # TODO: TOP(event)のルーティングを記述する
    root_path
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end
end
