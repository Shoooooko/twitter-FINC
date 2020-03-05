# frozen_string_literal: true

class Admins::BaseController < ApplicationController
  before_action :authenticate_admin!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :confirmation
  # skip_before_action :authenticate_user!
  def confirmation
    redirect_to admins_session_path unless admin_signed_in?
  end

  def after_sign_in_path_for(_resource)
    admins_users_path
  end

  protected

  def configure_permitted_parameters
    # 以下の:name部分は追加したカラム名に変える
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
