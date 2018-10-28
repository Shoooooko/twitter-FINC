# frozen_string_literal: true

class FavCommentsController < ApplicationController
    before_action :set_comment, only: [:exist_comment]
    before_action :exist_comment, only: [:create]

    def create
        @post=Post.find_by(id: params[:post])
        @comments=Comment.where(post_id: params[:post])
        if @favcount==0
            @fav = FavComment.create(user_id: current_user.id,
            comment_id: params[:comment])
            if @fav.save
                redirect_to post_comment_path(id: params[:comment], post_id: @post.id,fav: @favcount,notice: 'いいねしました！')
            else
                redirect_to post_comment_path(id: params[:comment],post_id: @post.id, fav: @favcount) 
            end
        else
            #binding.pry
            flash[:notice] = "すでにいいねしています"
            redirect_to post_comment_path(id: params[:comment], post_id: @post.id, fav: @favcount)
        end
    end
  end

  private

  def exist_comment
    @favcount = 0
    @favs = FavComment.where(comment_id: params[:comment])
    @favcount = @favs.count
  end

  def set_comment
    params.require(:comment).permit(:id, :body, :user_id, :post_id)
  end
end
