# frozen_string_literal: true

class Users::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :confirmation
  before_action :set_user

  def confirmation
    redirect_to users_session_path unless user_signed_in?
  end

  def set_user
    @user = current_user
  end

  def after_sign_in_path_for(resource)
    binding.pry
    homes_mypage_path(resource)
  end

  def after_sign_out_path_for(_resource)
    binding.pry
    homes_path # ログアウト後に遷移するpathを設定
  end

  protected

    def configure_permitted_parameters
      # sign_inのときに、nameも許可する
      binding.pry
      devise_parameter_sanitizer.for(:sign_in) << :name
      # sign_upのときに、nameも許可する
      devise_parameter_sanitizer.for(:sign_up) << :name
      #  account_updateのときに、nameも許可する
      devise_parameter_sanitizer.for(:account_update) << :name
    end
end
