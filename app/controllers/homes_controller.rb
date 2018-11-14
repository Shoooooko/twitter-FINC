# frozen_string_literal: true

class HomesController < Users::BaseController
  before_action :set_follower, only: :show
  skip_before_action :authenticate_user!, only: :index

  # GET /posts
  # loginしなくてもアクセスできる
  def index
    @posts = Post.where(trans: 1)
    # @posts = Post.eager_load(users: :settings).where(settings: {public_degree: 1})
    # @posts = Post.where(user_id: )
    # @user = User.eager_load(:settings).where(settings: {public_degree: 1})
    @settings = Setting.where(public_degree: 1)
    @posts = []
    # @settings.each do |s|
    #   if @posts == nil
    #     @posts = Post.where(user_id: s.user_id)
    #   else
    #     @posts.push(Post.where(user_id: s.user_id))
    #   end
    # end
  end

  # mypageからtimeline
  # loginしないとアクセスできない
  def show; end

  def mypage
    @mypost = Post.where(user_id: current_user.id)
  end

  private

  def set_follower
    @followers = Follow.where(followed: current_user.id)
    # @posts = Post.eager_load(users:)
    @followers.each do |f|
      if @f_posts.nil?
        @f_posts = Post.where(user_id: f.follower)
      else
        @f_posts.push(Post.where(user_id: f.follower))
      end
    end
  end
end
