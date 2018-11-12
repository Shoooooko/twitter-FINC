class Users::ApplicationController < ApplicationController
    protect_from_forgery with: :exception
    before_action :authenticate_user!
     # 以下を記述
    before_action :configure_permitted_parameters, if: :devise_controller?

    def set_user
        @user = current_user
    end


    def after_sign_in_path_for(resource)
        homes_mypage_path(resource)
    end

    protected

  def configure_permitted_parameters
    # 以下の:name部分は追加したカラム名に変える
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
