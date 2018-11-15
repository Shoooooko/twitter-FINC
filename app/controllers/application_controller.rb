# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception



  def after_sign_out_path_for(resource)
    if :user
      puts 'logout'
      homes_path # ログアウト後に遷移するpathを設定
    end
  end

end