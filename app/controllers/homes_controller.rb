# frozen_string_literal: true

class HomesController < Users::BaseController
  # GET /posts
  # loginしなくてもアクセスできる
  skip_before_action :authenticate_user!, only: :index
  skip_before_action :confirmation, only: :index
  skip_before_action :set_user, only: :index

  def index
    @posts = Post.where(trans: 1)
  end

  # mypage:loginしないとアクセスできない
  # @pageuserは、他人のmypage見るときのそのpageのowner

  def mypage
    @pageuser =
      if !get_params[:id].nil?
        User.find_by(id: get_params[:id])
      else
        @user
      end
    if @pageuser.id == @user.id
      @my_post = @pageuser.posts
      followers = @user.followers.pluck(:id)
      @posts = Post.where(user_id: followers, trans: [1, 3])
      @profile = Profile.find_by(user_id: @user.id)
      # if @profile.present?
      #   @user.name = @profile.nickname
      # end
      # 詳細見たいuserがloginuserをfollowしている、公開度：followers
    elsif @user.followed?(@pageuser)
      @my_post = @pageuser.posts.where(trans: [1, 3])
      # 詳細見たいuserがloginuserをfollowしていない、公開度：public
    else
      @my_post = Post.where(user_id: @pageuser.id, trans: 1)
    end
  end

  private

  def get_params
    params.permit(:id)
  end
end
