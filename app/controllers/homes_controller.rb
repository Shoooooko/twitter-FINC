# frozen_string_literal: true

class HomesController < ApplicationController
  before_action :set_follower, only: :show
  skip_before_action :authenticate_user!, only: :index

  # GET /posts
  # loginしなくてもアクセスできる
  def index
    @posts = Post.all
  end

  #mypageからtimeline
  # loginしないとアクセスできない
  def show
  end

  def mypage
    @mypost = Post.where(user_id: current_user.id)
  end

  private
    def set_follower
      @followers=Follow.where(followed: current_user.id)
      @followers.each do |f|
      @f_posts.push(Post.where(user_id: f.follower))
    end

end
