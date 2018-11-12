class Admins::ApplicationController < ApplicationController
    protect_from_forgery with: :exception
    before_action :authenticate_admin!
     # 以下を記述
    before_action :configure_permitted_parameters, if: :devise_controller?
    skip_before_action :authenticate_user!


    def after_sign_in_path_for(resource)
        admins_users_path
    end
end