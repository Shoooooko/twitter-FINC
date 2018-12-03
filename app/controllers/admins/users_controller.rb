# frozen_string_literal: true

class Admins::UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @person = User.find(params[:id])
    @u_posts = Post.where(user_id: params[:id])
  end
end
