# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_update_path_for(_resource)
    # TODO: アップデート後の遷移先を指定する
  end
end
