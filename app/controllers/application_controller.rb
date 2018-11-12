# frozen_string_literal: true

class ApplicationController < ActionController::Base
  #, :except => [:show]
  before_action :authentication

  def authentication
    if user_signed_in?
      redirect_to user_base_path
    end
  end
  
  # def authentication(resourse)
  #   case resource
  #     when User
  #       protect_from_forgery with: :exception
  #       authenticate_user!
  #       puts 'done'
  #       set_user
  #     when Admin
  #       authenticate_admin!
  #     end
  # end

  # def after_sign_in_path_for(resource)
  #   case resource
  #     when User
  #       homes_mypage_path(resource)
  #     when Admin
  #       admins_users_path
  #     end
  # end

  def after_sign_out_path_for(_resource)
    homes_path # ログアウト後に遷移するpathを設定
  end
end