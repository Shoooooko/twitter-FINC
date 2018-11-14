class Admins::BaseController < ApplicationController
    before_action :authenticate_admin!
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :confirmation
    #skip_before_action :authenticate_user!
    def confirmation
        unless admin_signed_in?
            redirect_to admins_session_path
        end
    end
    
    def after_sign_in_path_for(resource)
        admins_users_path
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