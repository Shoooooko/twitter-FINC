class Users::BaseController < ApplicationController
    before_action :authenticate_user!
     # 以下を記述
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :confirmation,:set_user
    puts 'base'

    def confirmation
        unless user_signed_in?
            redirect_to users_session_path
        end
    end

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

    def after_sign_out_path_for(_resource)
        homes_path # ログアウト後に遷移するpathを設定
    end
end
