class Users::MyPageController < Devise::MyPageController
    def index
        @user=current_user
    end
