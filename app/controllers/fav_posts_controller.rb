# frozen_string_literal: true

class FavPostsController < Users::BaseController
  before_action :set_post

  def create
    if @user.find_pfav?(@post)
      redirect_to posts_path, notice: "すでにいいねしています"
    else
      @user.create_pfav(@post)
      redirect_to posts_path, notice: "いいねしました！"
    end
  end

  def destroy
    if @user.find_pfav?(@post)
      @user.del_pfav(@post)
      redirect_to posts_path, notice: "いいねが取り消されました。"
    else
      redirect_to posts_path, notice: "いいねしていません"
    end
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end
end
