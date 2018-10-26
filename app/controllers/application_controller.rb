# frozen_string_literal: true

class ApplicationController < ActionController::Base
  require 'pry'
  before_action :authenticate_user!

  protect_from_forgery with: :exception

  def after_sign_in_path_for(_resource)
    home_mypage_path # Login後に遷移するpathを設定
  end

  def after_sign_out_path_for(_resource)
    home_path # ログアウト後に遷移するpathを設定
  end

  # 以下を記述
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # 以下の:name部分は追加したカラム名に変える
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
