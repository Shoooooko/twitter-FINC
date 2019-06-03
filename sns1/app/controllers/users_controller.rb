# frozen_string_literal: true

class UsersController < Users::BaseController
  # GET /posts
  # loginしなくてもアクセスできる
  skip_before_action :authenticate_user!, only: :index
  skip_before_action :confirmation, only: :index

  def index
    @posts = Post.where(trans: 1).order("created_at DESC")
  end

  # mypage:loginしないとアクセスできない
  # @page_userは、他人のmypage見るときのそのpageのowner
  #mypageのタイムライン
  #他人のpageでも自分のpageでも, その人のfollower＋selfの投稿が見られる
  def show
    @user = current_user
    @page_user = get_params[:id].present? ? User.find_by(id: get_params[:id]) : current_user
    @posts = current_user.follower_posts
    @profile = Profile.find_by(user_id: @page_user.id)
  end

  private

  def get_params
    params.permit(:id)
  end
end