# frozen_string_literal: true

class Admins::UsersController < Admins::BaseController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @person = User.find(params[:id])
    @u_posts = Post.where(user_id: params[:id])
  end
end
