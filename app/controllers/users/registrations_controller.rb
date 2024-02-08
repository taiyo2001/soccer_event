# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  protected

  # メソッド定義だけでupdate後はユーザ詳細に遷移する
  def after_update_path_for(_resource); end
end
